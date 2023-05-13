# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routes', type: :request do
  describe 'GET /users' do
    before do
      get "/users/#{path}"
    end

    context 'when the endpoint is valid' do
      let(:path) { '1' }

      it 'makes the correct request' do
        expect(response.header['Content-Type']).to include 'application/json'

        json_body = JSON.parse(response.body)

        expect(json_body).to have_key('id')
        expect(json_body['id']).to eq 1
      end
    end
  end

  describe 'GET /invalid' do
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

      it 'returns an empty path' do
        expect(response.status).to eq 404

        json_body = JSON.parse(response.body)

        expect(json_body).to have_key('error')
        expect(json_body['error']).to eq error_response_message
      end
    end
  end
end
