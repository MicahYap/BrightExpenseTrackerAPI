Rails.application.routes.draw do

  post 'login', to: 'users#login'
  post 'signup', to: 'users#create'
  delete 'logout', to: 'users#logout'

  resources :users do
    resources :expenses
  end

end
