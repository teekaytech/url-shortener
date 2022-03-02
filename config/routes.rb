Rails.application.routes.draw do
  root to: 'links#index'
  resources :links, only: %i[create destroy]
  get '/:code', to: 'links#show', as: 'current_link'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
