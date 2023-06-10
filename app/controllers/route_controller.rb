# frozen_string_literal: true

class RouteController < ApplicationController
  include UrlParser

  def index
    path = UrlParser.parse_path(initial_path)
    return unrecognised_endpoint if path == UNRECOGNISED_ENDPOINT_MSG

    uri = URI(path)
    # This does not handle /users/ as Net::HTTP does not handle 3xx
    # redirects, which dummyjson responds with for the /users endpoint
    response = Net::HTTP.get(uri)
    render json: response
  end

  private

  def initial_path
    params[:path] || ''
  end

  def unrecognised_endpoint
    payload = { message: UNRECOGNISED_ENDPOINT_MSG }
    render json: payload, status: :not_found
  end
end
