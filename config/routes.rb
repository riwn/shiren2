Rails.application.routes.draw do
#####################ログイン#####################
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
######################トップ######################
  get "/" => "home#top"
  get "/description" => "home#description"
  get "/opinion" => "home#opinion"
  post "/opinion" => "home#sendopinion"
#####################放送検索#####################
  get "/search" => "search#result" , as: "search"
#####################ユーザー#####################
  get "/user/:id" => "user#profile"
  get "/user/:id/edit" => "user#edit"
  post "/user/:id/update" => "user#update"
#######################解説#######################
  get "/ta" => redirect {"/ta/saihate"}
  get "/ta/saihate" => "ta#saihateta", as: "saihateta"
  get "/ta/well" => "ta#wellta", as: "wellta"
  get "/ta/onigashima" => "ta#onigashimata", as: "onigashimata"
  get "/ta/story" => "ta#storyta", as: "storyta"
  get "/ta/shrine" => "ta#shrineta", as: "shrineta"
  get "/ta/saihate/chapter1" =>"saihateta#chapter1"
  get "/ta/saihate/chapter2" =>"saihateta#chapter2"
  get "/ta/saihate/chapter3" =>"saihateta#chapter3"
  get "/ta/saihate/chapter4" =>"saihateta#chapter4"
  get "/ta/saihate/chapter5" =>"saihateta#chapter5"
  get "/ta/saihate/chapter6" =>"saihateta#chapter6"
####################ランキング####################
  get "/ranking" => redirect {"/"}, as: "ranking"
  post "/ranking" => "ranking#create"
  get "/ranking/newrecord" => "ranking#newrecord", as: "newrecord"
  post "/ranking/newrecord" => "ranking#recordconfirm"
  get "/ranking/description" => "ranking#description"
  get "/ranking/:dungeon" => "ranking#dungeon"
  get  "/ranking/:dungeon/:yyyymm" =>"ranking#dungeon"
#####################過去大会#####################
  get "/historys" => "historys#tournaments"
######################クイズ######################
  get "/quiz" => "quiz#quiz"

end
