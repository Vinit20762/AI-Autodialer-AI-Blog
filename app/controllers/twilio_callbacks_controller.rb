# app/controllers/twilio_callbacks_controller.rb
class TwilioCallbacksController < ApplicationController
  skip_forgery_protection # Twilio is an external service posting to us

  # Twilio hits this to know what to say
  def voice
    message = params[:message] || "Hello, this is the Aerolead test call."

    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say(message, voice: "Polly.Aditi") # Indian-ish TTS voice
    end

    render xml: response.to_s
  end

  # Twilio can post call status updates here (optional)
  def status
    call_sid    = params["CallSid"]
    call_status = params["CallStatus"]
    duration    = params["CallDuration"]

    log = CallLog.find_by(sid: call_sid)
    if log
      log.update(
        status:   call_status,
        duration: duration,
        ended_at: Time.current
      )
    end

    head :ok
  end
end
