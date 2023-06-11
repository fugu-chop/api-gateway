# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlParser do
  describe 'Parsing module' do
    subject { UrlParser }
    let(:action) { subject.parse_path(path) }
    let(:unrecognised_message) { 'Endpoint not recognised' }
    let(:url_root) { 'https://dummyjson.com/' }
    let(:redirected_path) { 'products/1' }

    context 'when given an unrecognised path' do
      let(:path) { 'ashdjfk' }
      it 'returns the correct error message' do
        expect(action).to eq unrecognised_message
      end
    end

    context 'when given a recognised path' do
      let(:path) { 'users/1' }

      it 'returns an appropriate URL' do
        expect(action).to eq url_root + path
      end
    end

    context 'when given a custom re-route path' do
      let(:path) { 'users/666' }

      it 'does not return a URL with the passed in path' do
        expect(action).not_to eq url_root + path
      end
    end
  end
end
