Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

   resources :pets do
    resources :problems, only: [:create, :new]
    resources :vaccinations
  end

  resources :problems, only: :show do
    resources :messages, only: [:create]
  end

end
