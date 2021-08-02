class MainController < ApplicationController
  def cubed
    @number = params[:number].to_i**3
  end

  def evenly
    num1 = params[:number1].to_i
    num2 = params[:number2].to_i
    @output = if (num1 % num2).zero?
                "#{num1} is evenly divisible by #{num2}."
              else
                "#{num1} is not evenly divisible by #{num2}."
              end
  end

  def length
    @word = params[:word]
  end

  def palindrome
    word = params[:word]
    @output = if word.downcase == word.reverse.downcase
                "#{word} is a palindrome"
              else
                "#{word} is not a palindrome"
              end
  end

  def madlib
    adjective = params[:adjective]
    animal = params[:animal]
    verb = params[:verb]
    noun1 = params[:noun1]
    noun2 = params[:noun2]
    adverb = params[:adverb]
    @output = "Today I went to the zoo. I saw a(n) #{adjective} #{animal} #{verb} up and down in its #{noun1}. It was eating a lot of #{noun2} and making really #{adverb} noises."
  end
end
