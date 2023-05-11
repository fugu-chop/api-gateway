require 'rails_helper'		

RSpec.describe "Routes", type: :request do
  describe "GET /invalid_url" do
    context "when an endpoint that doesn't start with /user is hit" do
      it "returns a JSON with an error" do
        get "/nonsense_url/asdf"

        expect(response.header['Content-Type']).to include 'application/json'
        expect(response.status).to eq 404

        response_body = JSON.parse(response.body)

        expect(response_body).to have_key("error")
        expect(response_body).not_to have_key("path")
        expect(response_body["error"]).to eq "Endpoint not recognised"
      end
    end
  end

  describe "GET /users" do
    before do
      get "/users/#{path}"
    end

    context "when the request is valid" do
      let(:path) { "abcdefg" }

      it "returns a JSON" do
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end

    context "when there is nothing else in the path" do 
      let(:path) { "" }

      it "has no additional information in the request body" do
        json_body = JSON.parse(response.body)
        
        expect(json_body).to have_key("path")
        expect(json_body["path"]).to eq ""
      end
    end

    context "when there is additional info in the path" do
      let(:path) { "123/456" }

      it "captures all subsequent path information in the request body" do        
        json_body = JSON.parse(response.body)
        
        expect(json_body).to have_key("path")
        expect(json_body["path"]).to include path
      end
    end
  end
end
