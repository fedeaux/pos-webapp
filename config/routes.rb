Rails.application.routes.draw do
  get 'templates/*name' => "dashboard#template"
  root 'dashboard#index'
end
