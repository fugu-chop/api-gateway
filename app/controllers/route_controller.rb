# frozen_string_literal: true

class RouteController < ApplicationController
  def index
    render json: { path: params[:path] }
  end

  def unrecognised_endpoint
    payload = { error: 'Endpoint not recognised' }
    render json: payload, status: :not_found
  end
end
