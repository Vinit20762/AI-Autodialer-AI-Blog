Rails.application.routes.draw do
  root "dialer#index"

  # Dialer UI
  post "/dialer/upload_numbers", to: "dialer#upload_numbers"
  post "/dialer/start_autodial", to: "dialer#start_autodial"
  post "/dialer/ai_prompt",      to: "dialer#ai_prompt"

  # Call logs
  resources :call_logs, only: [:index]

  # Blog – /blog path
  resources :blog_posts, path: "blog", only: [:index, :show, :new, :create] do
    collection do
      post :generate_from_ai   # POST /blog/generate_from_ai
    end
  end

  # Twilio webhook to update statuses (optional, advanced)
  post "/twilio/status", to: "twilio_callbacks#status"
  get "/twilio/voice", to: "twilio_callbacks#voice", as: :twiml_voice

end
