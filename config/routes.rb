Rails.application.routes.draw do
  get 'users/' => 'route#index'
  get 'users/*path' => 'route#index'
end
