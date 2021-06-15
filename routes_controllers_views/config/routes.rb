Rails.application.routes.draw do
  root 'main#landing'
  get '/landing' => 'main#landing'
  get '/short' => 'sarah#short'
  get '/pretty' => 'sarah#pretty'
  get '/sherlock' => 'sarah#sherlock'
  get '/porsche' => 'austin#porsche'
  get '/mclaren' => 'austin#mclaren'
  get '/ferrari' => 'austin#ferrari'
end
