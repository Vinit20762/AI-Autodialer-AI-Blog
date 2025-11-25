# Autodialer (Ruby on Rails)

Autodialer is a Ruby on Rails application that allows you to upload phone numbers, automatically call them using the Twilio Voice API, play a custom voice message, and track call logs.
The application also supports AI-based calling prompts and uses TailwindCSS for UI styling.

## Features

- Upload multiple phone numbers (one per line)
- Auto-dial all contacts using Twilio
- Play custom text-to-speech messages
- AI command support (example: `call +919876543210 saying hello`)
- Call logs with status, duration, SID, and error messages
- Twilio webhook integration for live call status updates
- TailwindCSS-based UI
- Ngrok support for local development
- Supports `.env` environment configuration

## Requirements

- Ruby 3.2+ or 3.4+
- Rails 8+
- Bundler
- Twilio account
- Ngrok (for local webhook testing)

## Installation

1. **Clone the repository**
   ```sh
   git clone https://github.com/your-username/autodialer.git
   cd autodialer
   ```

2. **Install gems**
   ```sh
   bundle install
   ```

3. **Set up the database**
   ```sh
   rails db:create
   rails db:migrate
   ```

4. **Set environment variables**

   Create a `.env` file with the following content:

   ```
   TWILIO_ACCOUNT_SID=your_account_sid
   TWILIO_AUTH_TOKEN=your_auth_token
   TWILIO_NUMBER=your_twilio_phone_number
   NGROK_URL=your_ngrok_domain.ngrok-free.dev
   OPENAI_API_KEY=your_api_key
   ```

5. **Run TailwindCSS watcher**
   ```sh
   rails tailwindcss:watch
   ```
   (Keep this running in a separate terminal)

6. **Start the Rails server**
   ```sh
   ruby bin/rails server
   ```

   The server will run at: [http://localhost:3000](http://localhost:3000)

## Ngrok Setup

1. Navigate to your ngrok folder:
   ```sh
   cd C:\ngrok-v3-stable-windows-amd64
   ```

2. Run ngrok:
   ```sh
   .\ngrok http 3000
   ```

3. Copy the generated domain and update your `.env` file:
   ```
   NGROK_URL=example-domain.ngrok-free.dev
   ```

## Twilio Setup

1. Open Twilio Console → Manage Numbers → Active Numbers → Configure.

2. Set the following:

   - **Voice webhook URL**
     ```
     https://YOUR_NGROK_URL/twilio/voice
     ```
   - **Status callback URL**
     ```
     https://YOUR_NGROK_URL/twilio/status
     ```

3. Save the configuration.

## Running Autodialer

1. Start TailwindCSS:
   ```sh
   rails tailwindcss:watch
   ```

2. Start Rails:
   ```sh
   ruby bin/rails server
   ```

3. Open the app in your browser:
   [http://localhost:3000](http://localhost:3000)

4. (If required) Use ngrok:
   ```sh
   .\ngrok http 3000
   ```

You can now receive Twilio calls on your personal phone (if verified under a trial account).

---

## Additional Notes

This README covers the necessary steps to get the application up and running.

You may also want to document:

- Ruby version
- System dependencies
- Configuration
- Database creation and initialization
- How to run the test suite
- Services (job queues, cache servers, search engines, etc.)
- Deployment instructions

Feel free to expand on these as needed for your application's requirements.
