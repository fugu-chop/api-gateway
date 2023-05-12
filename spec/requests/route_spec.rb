# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routes', type: :request do
  describe 'GET /' do
    before do
      get '/'
    end

    context 'when the request is valid' do
      it 'returns a JSON' do
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end

    context 'when there is no path' do
      it 'returns an empty path' do
        json_body = JSON.parse(response.body)

        expect(json_body).to have_key('path')
        expect(json_body['path']).to eq ''
      end
    end
  end

  describe 'GET /users' do
    before do
      get "/users/#{path}"
    end

    context 'when there is additional info in the path' do
      let(:path) { '123/456' }

      it 'captures all subsequent path information in the request body' do
        json_body = JSON.parse(response.body)

        expect(json_body).to have_key('path')
        expect(json_body['path']).to include path
      end
    end
  end
end
