# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routes', type: :request do
  describe 'GET /users', :vcr do
    before(:all) do
      Rails.application.load_seed
    end

    before do
      get "/users/#{path}"
    end

    context 'when the endpoint is valid' do
      let(:path) { '1' }

      it 'has the correct shape' do
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'has the correct response id' do
        json_body = JSON.parse(response.body)

        expect(json_body['id']).to eq 1
      end
    end

    context 'when there is a custom override' do
      let(:path) { '666' }

      it 'makes a request to the product endpoint' do
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'has the correct product response' do
        json_body = JSON.parse(response.body)

        expect(json_body).to have_key('brand')
      end
    end
  end

  describe 'GET /invalid', :vcr do
    before do
      get '/invalid'
    end

    context 'when the endpoint is invalid' do
      let(:error_response_message) { 'Endpoint not recognised' }

      it 'makes a request to the correct path' do
        expect(request.original_fullpath).to eq '/invalid'
      end

      it 'returns a JSON' do
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'returns an error response' do
        expect(response.status).to eq 404
      end

      it 'contains the correct error message' do
        json_body = JSON.parse(response.body)

        expect(json_body['message']).to eq error_response_message
      end
    end
  end
end
