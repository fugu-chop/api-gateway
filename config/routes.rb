# frozen_string_literal: true

Rails.application.routes.draw do
  root 'route#index'
  match '*path', to: 'route#index', via: :get
end
