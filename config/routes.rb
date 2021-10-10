Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "static#dashboard"
  get 'persons/:id', to: 'static#person' (Anbu, this should be people, not persons)
end
