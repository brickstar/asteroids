require "rails_helper"

describe "registered user" do
  it "returns a user with a valid API key" do
    user = create(:user, email: "uncle.jesse@example.com", name: "Jesse Katsopolis")
    api_key = create(:api_key)

    get "/api/v1/user?api_key=#{api_key.value}"

    expect(response.status).to eq 200

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to have_key :id
    expect(user).to_not have_key :password_digest

    expect(user[:email]).to eq "uncle.jesse@example.com"
    expect(user[:name]).to  eq "Jesse Katsopolis"
  end
end
=begin
As a registered user
When I send a 'GET' request to '/api/v1/user/favorites?api_key=abc123'
Then I should receive a JSON response as follows:

When I send a POST request to "/api/v1/user/favorites" with an 'api_key' of 'abc123' and a 'neo_reference_id' of '2021277'
Then I should receive a response with a status code of 200
And the body should be JSON as follows:
=end
