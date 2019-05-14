Rails.application.routes.draw do
#####################ログイン#####################
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
######################トップ######################
  get "/" => "home#top"
#####################放送検索#####################
  get "/search" => "search#result"
#####################ユーザー#####################
  get "/user/:id" => "user#profile"
  get "/user/:id/edit" => "user#edit"
  post "/user/:id/update" => "user#update"
#######################解説#######################
  get "/ta" => "home#ta"
  get "/ta/saihate/chapter1" =>"saihateta#chapter1"
  get "/ta/saihate/chapter2" =>"saihateta#chapter2"
  get "/ta/saihate/chapter3" =>"saihateta#chapter3"
  get "/ta/saihate/chapter4" =>"saihateta#chapter4"
  get "/ta/saihate/chapter5" =>"saihateta#chapter5"
  get "/ta/saihate/chapter6" =>"saihateta#chapter6"
####################ランキング####################
  get "/ranking" => redirect {"/"}
  post "/ranking" => "ranking#create"
  get "/ranking/newrecord" => "ranking#newrecord"
  post "/ranking/newrecord" => "ranking#recordconfirm"
  get "/ranking/:dungeon" => "ranking#dungeon"
  get  "/ranking/:dungeon/:yyyymm" =>"ranking#dungeon"
#####################過去大会#####################
  get "/historys" => "historys#tournaments"
######################クイズ######################
  get "/quiz" => "quiz#quiz"

end
