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
  get "/tool/search" => "tool#search" , as: "search"
  get "/tool/counter" => "tool#counter" , as: "counter"
#####################ユーザー#####################
  get "/user/:id" => "user#profile"
  get "/user/:id/edit" => "user#edit"
  post "/user/:id/update" => "user#update"
  post "/user/:id/update_password" => "user#update_password"
#######################解説#######################
  get "/explain/:dungeon" =>"explain#top"
  get "/explain/:dungeon/:id" =>"explain#explain"
  get "/explain/:dungeon/:id/edit" => "explain#edit"
  get "/explain/:dungeon/:id/edit/preview" => "explain#preview"
####################ランキング####################
  get "/ranking" => redirect {"/"}, as: "ranking"
  post "/ranking" => "ranking#create"
  get "/ranking/newrecord" => "ranking#newrecord", as: "newrecord"
  post "/ranking/newrecord" => "ranking#recordconfirm"
  get "/ranking/description" => "ranking#description"
  get "/ranking/:dungeon" => "ranking#dungeon"
  post "/ranking/:dungeon" =>"ranking#dungeon"
  get  "/ranking/:dungeon/:yyyymm" =>"ranking#dungeon"
  post "/ranking/:dungeon/:yyyymm" =>"ranking#dungeon"
#####################過去大会#####################
  # get "/historys" => "historys#tournaments"
######################クイズ######################
  # get "/quiz" => "quiz#quiz"
######################サイトマップ######################
  get 'sitemap.xml', to: redirect('https://s3-ap-northeast-1.amazonaws.com/shiren2records/sitemaps/sitemap.xml.gz')
end
