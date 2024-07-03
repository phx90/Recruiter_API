Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :recruiter do
        post 'recruiters/login', to: 'recruiters#login' # Mudança do caminho de login para o novo controlador
        resources :recruiters
        resources :jobs do
          resources :submissions, only: [:index, :create]
        end
        resources :submissions, except: [:index, :create]
      end

      namespace :public do
        resources :jobs, only: [:index, :show] do
          resources :submissions, only: [:create]
        end
      end
    end
  end
end
