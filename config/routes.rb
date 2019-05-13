Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  #get 'saihateta/1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#top"
  get "/search" => "search#result"
  get "/ta" => "home#ta"
  get "/ta/saihate/chapter1" =>"saihateta#chapter1"
  get "/ta/saihate/chapter2" =>"saihateta#chapter2"
  get "/ta/saihate/chapter3" =>"saihateta#chapter3"
  get "/ta/saihate/chapter4" =>"saihateta#chapter4"
  get "/ta/saihate/chapter5" =>"saihateta#chapter5"
  get "/ta/saihate/chapter6" =>"saihateta#chapter6"
  get "/ranking" => redirect {"/"}
  post "/ranking" => "ranking#create"

  get "/ranking/newrecord" => "ranking#newrecord"
  post "/ranking/newrecord" => "ranking#recordconfirm"

  get "/ranking/:dungeon" => "ranking#dungeon"
  get  "/ranking/:dungeon/:yyyymm" =>"ranking#dungeon"

  get "/historys" => "historys#tournaments"

  #クイズページ
  get "/quiz" => "quiz#quiz"

end
