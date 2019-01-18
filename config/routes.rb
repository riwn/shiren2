Rails.application.routes.draw do
  #get 'saihateta/1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#top"
  get "/ta" => "home#ta"
  get "/ranking" => "ranking#ranking"
  post "/ranking" => "ranking#create"
  get "/ta/chapter1" =>"saihateta#chapter1"
  get "/ranking/newrecord" => "ranking#newrecord"
  post "/ranking/newrecord" => "ranking#recordconfirm"
end
