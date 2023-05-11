class RouteController < ApplicationController
  def index
    render json: { path: parsed_path }
  end

  private

  def parsed_path
    params[:path] || ""
  end
end
