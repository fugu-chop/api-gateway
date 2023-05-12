# frozen_string_literal: true

Rails.application.routes.draw do
  match '*path', to: 'route#index', via: :get
end
