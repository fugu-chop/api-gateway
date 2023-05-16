# frozen_string_literal: true

class RouteController < ApplicationController
  ROUTE_TABLE_LOCATION = "#{Rails.root}/config/gateway_routes.yml".freeze
  UNRECOGNISED_ENDPOINT_MSG = 'Endpoint not recognised'

  def index
    return unrecognised_endpoint if parsed_path == UNRECOGNISED_ENDPOINT_MSG

    uri = URI(parsed_path)
    # This does not handle /users/ as Net::HTTP does not handle 3xx
    # redirects, which dummyjson responds with for the /users endpoint
    response = Net::HTTP.get(uri)
    render json: response
  end

  private

  def initial_path
    params[:path] || ''
  end

  def parsed_path
    routes = YAML.safe_load(File.open(ROUTE_TABLE_LOCATION))
    service, *resource = initial_path.split('/')
    redirected_route = routes[service]

    return "#{redirected_route}/#{resource.join('/')}" if redirected_route
    UNRECOGNISED_ENDPOINT_MSG
  end

  def unrecognised_endpoint
    payload = { message: UNRECOGNISED_ENDPOINT_MSG }
    render json: payload, status: :not_found
  end
end
