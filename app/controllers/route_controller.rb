# frozen_string_literal: true

class RouteController < ApplicationController
  ROUTE_TABLE_LOCATION = "#{Rails.root}/config/gateway_routes.yml".freeze
  OVERRIDE_TABLE_LOCATION = "#{Rails.root}/config/override_routes.yml".freeze
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

  def custom_override_routes
    @custom_override_routes ||= YAML.safe_load(File.open(OVERRIDE_TABLE_LOCATION))
  end

  def loaded_routes
    @loaded_routes ||= YAML.safe_load(File.open(ROUTE_TABLE_LOCATION))
  end

  def initial_path
    params[:path] || ''
  end

  def parsed_path
    path_to_parse = initial_path

    path_to_parse = find_custom_route(initial_path) if custom_route_exists?(custom_override_routes, initial_path)

    create_uri(loaded_routes, path_to_parse)
  end

  def create_uri(routes, path)
    service, *resource = path.split('/')
    redirected_route = routes[service]
    return "#{redirected_route}/#{resource.join('/')}" if redirected_route

    UNRECOGNISED_ENDPOINT_MSG
  end

  def custom_route_exists?(_override_routes, path)
    !!custom_override_routes[path]
  end

  def find_custom_route(path)
    custom_override_routes[path] || path
  end

  def unrecognised_endpoint
    payload = { message: UNRECOGNISED_ENDPOINT_MSG }
    render json: payload, status: :not_found
  end
end
