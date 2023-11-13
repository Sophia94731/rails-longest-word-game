require "open-uri"

class GamesController < ApplicationController
  def new
    def generate_grid(grid_size)
      Array.new(grid_size) { ('A'..'Z').to_a.sample.upcase }
    end
    @letters = generate_grid(10)
  end

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def form_a_word?(word, letters)
    word.chars.all? { |letter| letters.include?(letter) }
  end

  def score
    @input = params[:mot].upcase
    @letters = params[:letters]
    if form_a_word?(@input, @letters)
      if !english_word?(@input)
        @result = "Sorry, #{@input} doesn't seem to be a valid English word."
      else
        @result = "Congratulations, #{@input} is a valid English word!"
      end
    else
      @result = "Sorry but #{@input} can't be fully created out of #{@letters}"
    end
  end
end
