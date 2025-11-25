# app/services/twilio_client.rb

class TwilioClient
  require "twilio-ruby"

  def initialize
    @account_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
    @auth_token  = ENV.fetch("TWILIO_AUTH_TOKEN")
    @from_number = ENV.fetch("TWILIO_FROM_NUMBER") # e.g. "+15005550006" (Twilio test number)
    @client      = Twilio::REST::Client.new(@account_sid, @auth_token)
  end

  # message: text the TTS voice will speak
  def call_number(to_number, message:)
    @client.calls.create(
      from: @from_number,
      to:   to_number,
      # This URL should return TwiML. For now we’ll hit our Rails endpoint.
      url: Rails.application.routes.url_helpers.twiml_voice_url(message: message, host: ENV.fetch("PUBLIC_HOST", "localhost:3000"))
    )
  end
end
