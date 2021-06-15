Rails.application.routes.draw do
  get '/cubed/:number' => 'main#cubed'
  get '/evenly/:number1/:number2' => 'main#evenly'
  get '/length/:word' => 'main#length'
  get '/palindrome/:word' => 'main#palindrome'
  get '/madlib/:adjective/:animal/:verb/:noun1/:noun2/:adverb' => 'main#madlib'
end
