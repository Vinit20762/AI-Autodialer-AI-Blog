class DialerController < ApplicationController
  def index
    @contacts   = Contact.order(created_at: :desc).limit(100)
    @call_logs  = CallLog.order(created_at: :desc).limit(50)

    @stats = {
      total_contacts: Contact.count,
      total_calls:    CallLog.count,
      answered:       CallLog.where(status: "completed").count,
      failed:         CallLog.where(status: "failed").count
    }
  end

  # Paste numbers (one per line) and optional message
  def upload_numbers
    numbers_text = params[:numbers_text].to_s
    numbers      = numbers_text.split(/\r?\n/).map(&:strip).reject(&:blank?)

    numbers.each do |num|
      Contact.find_or_create_by(phone_number: num)
    end

    redirect_to root_path, notice: "#{numbers.size} numbers added."
  end

  # Simple sequential autodial – calls all contacts
  def start_autodial
    message = params[:call_message].presence || "Hello, this is a test call from the Autodialer app."

    twilio = TwilioClient.new

    Contact.find_each do |contact|
      begin
        call = twilio.call_number(contact.phone_number, message: message)

        CallLog.create!(
          phone_number: contact.phone_number,
          status:       "queued",
          started_at:   Time.current,
          sid:          call.sid
        )

        contact.update!(
          status:        "queued",
          last_called_at: Time.current,
          last_call_sid:  call.sid
        )
      rescue => e
        CallLog.create!(
          phone_number:  contact.phone_number,
          status:        "failed",
          error_message: e.message
        )
      end
    end

    redirect_to call_logs_path, notice: "Autodial started (using Twilio test numbers for safety)."
  end

  # AI prompt like: "Make a call to 18001234567 saying test message"
  def ai_prompt
    prompt = params[:ai_prompt].to_s
    ai     = AiClient.new
    parsed = ai.parse_call_prompt(prompt)

    numbers = parsed["numbers"] || []
    message = parsed["message"] || "Hello, this is a test call from Autodialer."

    twilio = TwilioClient.new

    numbers.each do |num|
      contact = Contact.find_or_create_by(phone_number: num)

      begin
        call = twilio.call_number(num, message: message)

        CallLog.create!(
          phone_number: num,
          status:       "queued",
          started_at:   Time.current,
          sid:          call.sid
        )

        contact.update!(
          status:        "queued",
          last_called_at: Time.current,
          last_call_sid:  call.sid
        )
      rescue => e
        CallLog.create!(
          phone_number:  num,
          status:        "failed",
          error_message: e.message
        )
      end
    end

    redirect_to call_logs_path, notice: "AI prompt processed for #{numbers.size} numbers."
  end
end
