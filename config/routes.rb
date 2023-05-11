Rails.application.routes.draw do
  get 'users/' => 'route#index'
  get 'users/*path' => 'route#index'

  match '*unmatched', to: 'route#unrecognised_endpoint', via: :get
end
