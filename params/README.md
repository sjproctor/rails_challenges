# Rails Params Challenges
Updated: June 2021

- As a user, I can visit a page called cubed that takes a number as a param and displays that number cubed.
  - Controller
  ```ruby
  class MainController < ApplicationController
    def cubed
      @number = params[:number].to_i ** 3
    end
  end
  ```
  - View
  ```html
  <h2>Number Cubed</h2>
  <p><%= @number %></p>
  ```
  - Route
  ```ruby
  Rails.application.routes.draw do
    get '/cubed/:number' => 'main#cubed'
  end
  ```
- As a user, I can visit a page called evenly that takes two numbers and displays whether or not the first number is evenly divisible by the second.
  - Controller
  ```ruby
  def evenly
    num1 = params[:number1].to_i
    num2 = params[:number2].to_i
    if num1 % num2 == 0
      @output = "#{num1} is evenly divisible by #{num2}."
    else
      @output = "#{num1} is not evenly divisible by #{num2}."
    end
  end
  ```
  - View
  ```html
  <h2>Number Divided By</h2>
  <p><%= @output %></p>
  ```
  - Route
  ```ruby
  get '/evenly/:number1/:number2' => 'main#evenly'
  ```
- As a user, I can visit a page called length that takes in a string and displays how many characters are in the string.
  - Controller
  ```ruby
  def length
    @word = params[:word]
  end
  ```
  - View
  ```html
  <h2>Length of String</h2>
  <p>The string <%= @word %> is <%= @word.length %> characters long.</p>
  ```
  - Route
  ```ruby
  get '/length/:word' => 'main#length'
  ```
- As a user, I can visit a page called palindrome that takes a string and displays whether it is a palindrome (the same word read forward and backward).
  - Controller
  ```ruby
  def palindrome
    word = params[:word]
    if word.downcase == word.reverse.downcase
      @output = "#{word} is a palindrome"
    else
      @output = "#{word} is not a palindrome"
    end
  end
  ```
  - View
  ```html
  <h2>Palindrome</h2>
  <p><%= @output.capitalize %></p>
  ```
  - Route
  ```ruby
  get '/palindrome/:word' => 'main#palindrome'
  ```
- As a user, I can visit a page called madlib that takes params of a noun, verb, adjective, adverb, and displays a short silly story.
  - Controller
  ```ruby
  def madlib
    adjective = params[:adjective]
    animal = params[:animal]
    verb = params[:verb]
    noun1 = params[:noun1]
    noun2 = params[:noun2]
    adverb = params[:adverb]
    @output = "Today I went to the zoo. I saw a(n) #{adjective} #{animal} #{verb} up and down in its #{noun1}. It was eating a lot of #{noun2} and making really #{adverb} noises."
  end
  ```
  - View
  ```html
  <h2>Madlib</h2>
  <p><%= @output %></p>
  ```
  - Route
  ```ruby
  get '/madlib/:adjective/:animal/:verb/:noun1/:noun2/:adverb' => 'main#madlib'
  ```
