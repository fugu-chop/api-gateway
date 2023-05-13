# frozen_string_literal: true

class RouteController < ApplicationController
  ROUTE_TABLE_LOCATION = "#{Rails.root.to_s}/config/gateway_routes.yml"
  UNRECOGNISED_ENDPOINT_MSG = "Endpoint not recognised"

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
    routes = YAML::load(File.open(ROUTE_TABLE_LOCATION))
    service, *resource = initial_path.split("/") 
    redirected_route = routes[service]

    if redirected_route
      redirected_route + "/" + resource.join('/')
    else    
      UNRECOGNISED_ENDPOINT_MSG
    end
  end

  def unrecognised_endpoint
    payload = { error: UNRECOGNISED_ENDPOINT_MSG }
    render json: payload, status: :not_found
  end
end
