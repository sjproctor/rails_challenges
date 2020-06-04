Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/question' => 'question#joke_setup'
  get '/answer' => 'answer#joke_punchline'
end
