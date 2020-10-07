Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :offers, only: [:index, :show, :create] do
        member do
          patch :accept
          patch :reject
        end
      end
    end
  end
end
