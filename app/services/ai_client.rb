# app/services/ai_client.rb
class AiClient
  include HTTParty
  base_uri "https://api.openai.com/v1"

  def initialize
    @api_key = ENV.fetch("OPENAI_API_KEY")
  end

  # Parse a natural language prompt like:
  # "make a call to 18001234567 and 18007654321 saying hello"
  # Returns { numbers: ["18001234567", ...], message: "..." }
  def parse_call_prompt(prompt)
    body = {
      model: "gpt-4.1-mini",
      response_format: { type: "json_object" },
      messages: [
        {
          role: "system",
          content: "You extract phone numbers and a short message from the user's request. Respond as JSON: {\"numbers\": [\"...\"], \"message\": \"...\"} with Indian phone style allowed, no extra keys."
        },
        { role: "user", content: prompt }
      ]
    }

    response = self.class.post(
      "/chat/completions",
      headers: {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type"  => "application/json"
      },
      body: body.to_json
    )

    json = JSON.parse(response.body)
    content = json["choices"][0]["message"]["content"]
    JSON.parse(content) # => {"numbers" => [...], "message" => "..."}
  rescue => e
    Rails.logger.error("AI parse error: #{e.message}")
    { "numbers" => [], "message" => "Hello, test call from Autodialer." }
  end

  # Generate multiple blog articles from list of titles + notes
  # titles_param is something like:
  # "1. Intro to Ruby on Rails\n2. What is REST API?\n..."
  def generate_articles(titles_param)
    body = {
      model: "gpt-4.1-mini",
      response_format: { type: "json_object" },
      messages: [
        {
          role: "system",
          content: "You are a programming educator. Given a list of titles, write 600-800 word blog posts for each. Respond as JSON: {\"articles\": [{\"title\": \"...\", \"body\": \"...\"}, ...]}."
        },
        { role: "user", content: titles_param }
      ]
    }

    response = self.class.post(
      "/chat/completions",
      headers: {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type"  => "application/json"
      },
      body: body.to_json
    )

    json = JSON.parse(response.body)
    content = json["choices"][0]["message"]["content"]
    JSON.parse(content)["articles"] # => array of { "title" => ..., "body" => ...}
  rescue => e
    Rails.logger.error("AI blog error: #{e.message}")
    []
  end
end
