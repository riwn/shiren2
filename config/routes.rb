Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#top"
  get "/ta" => "home#ta"
  get "/sa" => "home#sa"
  get "/other" => "home#other"
  get "/ranking" => "home#ranking"
end
