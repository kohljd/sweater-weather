require "rails_helper"

RSpec.describe "POST /api/v0/users" do
  it "registers a user" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "email": "unknown@email.com",
      "password": "the_most_secure_password",
      "password_confirmation": "the_most_secure_password"
    }

    post "/api/v0/users", params: body, headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(201)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    user = parsed_response[:data]

    expect(user[:id]).to eq(User.last.id.to_s)
    expect(user[:type]).to eq("users")
    expect(user[:attributes]).to include(:email, :api_key)
  end
end