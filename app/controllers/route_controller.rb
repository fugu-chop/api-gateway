class RouteController < ApplicationController
  def index
    render json: { path: parsed_path }
  end

  def unrecognised_endpoint
    payload = {error: "Endpoint not recognised"}
    render :json => payload, :status => :not_found
  end

  private

  def parsed_path
    params[:path] || ""
  end
end
