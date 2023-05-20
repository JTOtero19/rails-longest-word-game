require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    word = params[:respuesta].upcase
    letters = params[:letters].split
    @result = if !word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
      "La palabra no puede crearse a partir de la cuadrícula original"
    elsif !english_word?(word)
      "La palabra es válida de acuerdo a la cuadrícula, pero no es una palabra en inglés válida"
    else
      "La palabra es válida de acuerdo a la cuadrícula y es una palabra en inglés válida"
    end
  end

  private

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
    # url = "https://wagon-dictionary.herokuapp.com/#{word}"
    # response = URI.open(url).read
    # user = JSON.parse(response)
  end
end
