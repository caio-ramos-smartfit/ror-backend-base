Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  devise_for :users, skip: :all
  
  namespace :api do
    namespace :v1 do
      post 'auth/sign_up', to: 'auth#sign_up'
      post 'auth/sign_in', to: 'auth#login'
      delete 'auth/sign_out', to: 'auth#sign_out'
      get 'auth/me', to: 'auth#me'
    end
  end
end
