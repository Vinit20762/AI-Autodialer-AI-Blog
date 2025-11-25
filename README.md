# README

Autodialer (Ruby on Rails)

Autodialer is a Ruby on Rails application that allows you to upload phone numbers, automatically call them using Twilio Voice API, play a custom voice message, and track call logs.
The application also supports AI-based calling prompts and uses TailwindCSS for UI styling.

Features

Upload multiple phone numbers (one per line)

Auto-dial all contacts using Twilio

Play custom text-to-speech messages

AI command support (example: “call +919876543210 saying hello”)

Call logs with status, duration, SID, and error messages

Twilio webhook integration for live call status updates

TailwindCSS-based UI

Ngrok support for local development

Supports .env environment configuration

Requirements

Ruby 3.2+ or 3.4

Rails 8+

Bundler

Twilio account

Ngrok (for local webhook testing)

Installation
1. Clone the repository
git clone https://github.com/your-username/autodialer.git
cd autodialer

2. Install gems
bundle install

3. Set up the database
rails db:create
rails db:migrate

4. Set environment variables

Create a .env file:

TWILIO_ACCOUNT_SID=your_account_sid
TWILIO_AUTH_TOKEN=your_auth_token
TWILIO_NUMBER=your_twilio_phone_number
NGROK_URL=your_ngrok_domain.ngrok-free.dev
OPENAI_API_KEY=your_api_key

5. Run TailwindCSS watcher
rails tailwindcss:watch


(Keep this running in a separate terminal)

6. Start Rails server
ruby bin/rails server


Server will run at:

http://localhost:3000

Ngrok Setup

Navigate to your ngrok folder:

cd C:\ngrok-v3-stable-windows-amd64


Run:

.\ngrok http 3000


Copy the generated domain and update your .env:

NGROK_URL=example-domain.ngrok-free.dev

Twilio Setup

Open Twilio Console → Manage Numbers → Active Numbers → Configure.

Set:

Voice webhook URL

https://YOUR_NGROK_URL/twilio/voice


Status callback URL

https://YOUR_NGROK_URL/twilio/status


Save configuration.

Running Autodialer

Start Tailwind:

rails tailwindcss:watch


Start Rails:

ruby bin/rails server


Open the app:

http://localhost:3000


Use ngrok:

.\ngrok http 3000


You can now receive Twilio calls on your personal phone (if verified under a trial account).

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
