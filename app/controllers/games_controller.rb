require 'open-uri'

class GamesController < ApplicationController
  def new
    @sample = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @sample = params[:sample]
    if english_word?(params[:guess])
      @eng_word = "Cool, this is an english word"
    else
     @eng_word = "this is NOT an english word!"
    end
    if included?(@sample, params[:guess])
      @incl = "Cool, all the letters are included in the grid"
    else
      @incl = "oh no you tried to cheat"
    end
  end


  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(grid, guess)
    index = 0
    guess.chars.each do |letter|
      index += 1 if guess.count(letter) == guess.count(letter)
    end
    index == grid.length
  end

end
