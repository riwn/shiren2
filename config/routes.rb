Rails.application.routes.draw do
  #get 'saihateta/1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#top"
  get "/ta" => "home#ta"
  get "/ranking" => "ranking#ranking"
  get "/ta/chapter1" =>"saihateta#chapter1"
  get "/ranking/requestrecord" => "ranking#requestrecord"
  post "/ranking/requestrecord" => "ranking#requestrecord"
end
