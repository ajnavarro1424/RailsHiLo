class GameController < ApplicationController
  # Runs the logic behind the guesses and comparisons
  def try
    session[:guess_counter] = Array.new if session[:guess_counter].nil?
    @guess_counter = session[:guess_counter]

    if @rand == nil
      r = Random.new
      session[:rand] = r.rand(1..100) if session[:rand].nil?
      @rand = session[:rand]
    end

    @player = params[:player]
    if params[:player] == nil
      @player = "No username entered"
    end

    @guess = params[:guess]
    if @guess != nil
      # Deicison tree to evaluate @guess to @rand
      if @guess.to_i == @rand.to_i
        @response = "You guessed right!"
        reset
      elsif @guess.to_i < @rand.to_i
        @response = "You're too low!"

      else
        @response = "You're too high!"
      end
      session[:guess_counter] << params[:guess]
    end

  end
  # Resets the game
  def reset
    @guess = nil
    @response = ""
    @rand = nil
    session[:guess_counter] = nil
    redirect_to "/game"
  end
end
