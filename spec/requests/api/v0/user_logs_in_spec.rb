require "rails_helper"

RSpec.describe "POST /api/v0/sessions" do
  let(:user) { User.create!(email: "unknown@email.com", password: "the_most_secure_password", password_confirmation: "the_most_secure_password", api_key: "ea2f6e7441fab8aa96f1611a0361c60d") }

  it "creates session when user logs in" do
    require 'pry'; binding.pry
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "email": "unknown@email.com",
      "password": "the_most_secure_password",
    }

    post "/api/v0/sessions", params: body, headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(201)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    session = parsed_response[:data]

    expect(session[:id]).to eq(user.id)
    expect(session[:type]).to eq("users")
    expect(session[:attributes][:email]).to eq(user.email)
    expect(session[:attributes][:api_key]).to eq(user.api_key)
  end

  it "must provide user email/password" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "email": "",
      "password": "",
    }

    post "/api/v0/sessions", params: body, headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    errors = parsed_response[:errors]

    expect(errors[0][:status]).to eq(400)
    expect(errors[0][:detail]).to eq("Validation failed: Email can't be blank, Email is invalid, Password can't be blank")
  end

  it "require valid user email" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "email": "incorrect@email.com",
      "password": "the_most_secure_password",
    }

    post "/api/v0/sessions", params: body, headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    errors = parsed_response[:errors]

    expect(errors[0][:status]).to eq(404)
    expect(errors[0][:detail]).to eq("Validation failed: Password confirmation doesn't match Password")
  end

  it "require valid user password" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "email": "unknown@email.com",
      "password": "incorrect",
    }

    post "/api/v0/sessions", params: body, headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    errors = parsed_response[:errors]

    expect(errors[0][:status]).to eq(400)
    expect(errors[0][:detail]).to eq("Validation failed: Password is invalid")
  end
end