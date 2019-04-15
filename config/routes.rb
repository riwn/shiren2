Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #get 'saihateta/1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#top"
  get "/search" => "search#result"
  get "/ta" => "home#ta"
  get "/ta/chapter1" =>"saihateta#chapter1"
  get "/ta/chapter2" =>"saihateta#chapter2"
  get "/ta/chapter3" =>"saihateta#chapter3"
  get "/ta/chapter4" =>"saihateta#chapter4"
  get "/ta/chapter5" =>"saihateta#chapter5"
  get "/ta/chapter6" =>"saihateta#chapter6"
  get "/ranking" => redirect {"/"}
  post "/ranking" => "ranking#create"

  get "/ranking/newrecord" => "ranking#newrecord"
  post "/ranking/newrecord" => "ranking#recordconfirm"

  get "/ranking/:dungeon" => "ranking#dungeon"
  get  "/ranking/:dungeon/:yyyymm" =>"ranking#dungeon"

  get "/historys" => "historys#tournaments"

end
