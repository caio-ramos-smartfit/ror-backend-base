Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  devise_for :users, skip: :all
  
  namespace :api do
    namespace :v1 do
      namespace :auth do
        post 'sign_up', to: 'auth#sign_up'
        post 'sign_in', to: 'auth#sign_in'
        delete 'sign_out', to: 'auth#sign_out'
        get 'me', to: 'auth#me'
      end
    end
  end
end
