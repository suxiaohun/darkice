Rails.application.routes.draw do
  get 'xiuxian/index'
  get 'questions/order',to: "questions#run_in_order"
  get 'questions/random',to: "questions#run_in_random"
  get 'questions/refresh_ids',to: "questions#refresh_ids"

  resources :questions



  devise_for :users
  get 'show2', to: "posts#show2"
  resources :posts do
    resources :comments

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'feishu', to: 'common#feishu'
  get 'index', to: 'common#index'
  get 'index2', to: 'common#index2'
  get 'encode_upload', to: 'common#encode_upload'
  post 'encode_convert', to: 'common#encode_convert'

  match 'chatgpt', to: 'common#chatgpt', :via => [:get, :post]

  get 'persons/index'
  get 'search/index'

  post 'identity/image_verification', to: 'identity#image_verification'



  get 'deploy', to: 'tools#deploy'
  post 'tools/service_update', to: 'tools#service_update'
  get 'img_to_base64', to: 'tools#img_to_base64'
  post 'img_to_base64', to: 'tools#img_to_base64'

  get 'chat', to: 'chat_rooms#index'
  post 'chat/publish', to: 'chat_rooms#publish'
  get 'compress', to: 'tools#compress'
  get 'sense', to: 'tools#sense'
  post 'sense_encode', to: 'tools#sense_encode'
  get 'test_timeout', to: 'common#test_timeout'
  get 'test', to: 'common#test'
  get 'markdown', to: 'tools#markdown'
  get 'hammerspoon', to: 'tools#hammerspoon'
  get 'wow', to: 'tools#wow'
  get 'screen', to: 'tools#screen'
  get 'authorization', to: 'tools#authorization'
  post 'authorization', to: 'tools#authorization'

  get 'skills', to: 'common#skills'
  get 'items', to: 'common#items'
  get 'groups', to: 'common#groups'
  get 'rpc', to: 'tools#rpc'
  get 'rpc2', to: 'tools#rpc2'

  match 'fates/auth', to: 'fates#auth', :via => [:get, :post]

  resources :fates
  get 'yys', to: 'yys#index'

  get 'test', to: "yys#test"

  post 'yys/update_info', to: 'yys#update_info'
  get 'yys/guess', to: 'yys#guess'
  get 'yys/simulate', to: 'yys#simulate'
  match 'yys/auth', to: 'yys#auth', :via => [:get, :post]
  get 'yys/rate', to: 'yys#rate'
  post 'yys/summon', to: 'yys#summon'
  get 'yys/manage', to: 'yys#manage'
  post 'yys/update_manage', to: 'yys#update_manage'
  post 'yys/add_ss', to: 'yys#add_ss'
  post 'yys/add_patch', to: 'yys#add_patch'
  post 'yys/add_region', to: 'yys#add_region'

  match 'books/auth', to: 'books#auth', :via => [:get, :post]
  post 'books/category/:id', to: 'books#category'
  post 'books/prev/:start_pos/:id', to: 'books#prev'
  post 'books/next/:start_pos/:id', to: 'books#next'
  post 'books/goto', to: 'books#goto'
  post 'books/page_size', to: 'books#page_size'
  get 'books/es', to: 'books#es'
  get 'books/es_search', to: 'books#es_search'

  resources :books

  get 'colors', to: 'tools#colors'

  match 'json', to: 'tools#json', :via => [:get, :post]
  match 'sign', to: 'tools#sign', :via => [:get, :post]
  get 'unicode', to: 'tools#unicode'
  get 'json_format', to: 'tools#json_format'
  get 'mobile_area', to: 'tools#mobile_area'
  post 'get_mobile_area', to: 'tools#get_mobile_area'
  post 'comment_save', to: 'tools#comment_save'
  get '/v2/pause/manifests/3.1', to: 'tools#mirror'

  root 'common#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
