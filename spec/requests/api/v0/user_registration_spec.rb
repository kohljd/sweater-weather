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

  it "user data can't be blank" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "email": "",
      "password": "",
      "password_confirmation": ""
    }

    post "/api/v0/users", params: body, headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    errors = parsed_response[:errors]

    expect(errors[0][:status]).to eq(400)
    expect(errors[0][:detail]).to eq("Validation failed: Email can't be blank, Email is invalid, Password confirmation can't be blank, Password can't be blank")
  end

  it "password and password confirmation must match" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "email": "new_user@email.com",
      "password": "an_unforgettable_password",
      "password_confirmation": "that's_already_forgotten"
    }

    post "/api/v0/users", params: body, headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    errors = parsed_response[:errors]

    expect(errors[0][:status]).to eq(400)
    expect(errors[0][:detail]).to eq("Validation failed: Password confirmation doesn't match Password")
  end

  it "must enter valid email format" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "email": "new_user@",
      "password": "original",
      "password_confirmation": "original"
    }

    post "/api/v0/users", params: body, headers: headers

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    errors = parsed_response[:errors]

    expect(errors[0][:status]).to eq(400)
    expect(errors[0][:detail]).to eq("Validation failed: Email is invalid")
  end

  it "can't register user a second time" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "email": "unknown@email.com",
      "password": "the_most_secure_password",
      "password_confirmation": "the_most_secure_password"
    }

    post "/api/v0/users", params: body, headers: headers
    expect(response).to be_successful
    
    post "/api/v0/users", params: body, headers: headers
    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    errors = parsed_response[:errors]

    expect(errors[0][:status]).to eq(422)
    expect(errors[0][:detail]).to eq("Validation failed: Email has already been taken")
  end
end