Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #get 'saihateta/1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#top"
  get "/search" => "search#result"
  get "/ta" => "home#ta"
  get "/ta/chapter1" =>"saihateta#chapter1"
  get "/ta/chapter2" =>"saihateta#chapter1"

  get "/ranking" => "ranking#ranking"
  get "/ranking/saihate" => "ranking#saihate"
  get "/ranking/shrine" => "ranking#shrine"
  get "/ranking/story" => "ranking#story"
  get "/ranking/onigashima" => "ranking#onigashima"
  get "/ranking/well" => "ranking#well"
  post "/ranking" => "ranking#create"
  get "/ranking/newrecord" => "ranking#newrecord"
  post "/ranking/newrecord" => "ranking#recordconfirm"
  get  "/ranking/:yyyymm" =>"ranking#archives"


end
