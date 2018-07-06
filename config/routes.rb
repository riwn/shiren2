Rails.application.routes.draw do
  get 'saihateta/1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#top"
  get "/ta" => "home#ta"
  get "/sa" => "home#sa"
  get "/other" => "home#other"
  get "/ranking" => "home#ranking"
  get '/ta/saihateta' =>"ta#saihateta"
  get "/ta/saihateta/chapter1" =>"saihateta#chapter1"
  get '/ta/storyta' =>"ta#storyta"
  get '/ta/onigashima' =>"ta#onigashima"
  get '/ta/karakuro' =>"ta#karakuro"
  get '/sa/saihatesa' =>"sa#saihatesa"
  get '/ranking/rank' =>"ranking#rank"
  get '/other/hakaiteki' =>"other#hakaiteki"
end
