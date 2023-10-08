Rails.application.routes.draw do
  get 'show2',to: "posts#show2"
  resources :posts do
    resources :comments

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
