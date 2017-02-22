class GameController < ApplicationController
  # Runs the logic behind the guesses and comparisons
  def try
    session[:guess_counter] = Array.new if session[:guess_counter].nil?
    @guess_counter = session[:guess_counter]
    if @guess_counter.length>6
      flash.now[:alert] = %Q[You've run out of guesses! Please restart the game.
        <form  action="new_game" method="get">
          <input type="submit" v? alue="Reset">
        </form>
      ]

    end

    @rand = session[:rand]
    if @rand.blank?
      puts "-----New Random Number!!!--------"
      r = Random.new
      session[:rand] = r.rand(1..100)
      @rand = session[:rand]
    end


    session[:username] = params[:username] if session[:username] != params[:username] && !params[:username].blank?
    @player = session[:username]

    if @player.blank?
      @player = "No username entered"
    end

    @guess = params[:guess]
    if @guess != nil && @guess_counter.length<7
      # Deicison tree to evaluate @guess to @rand
      if @guess.to_i == @rand.to_i
        @response = "You guessed right!"
        reset
      elsif @guess.to_i < @rand.to_i
        @response = "You're too low!"
        session[:guess_counter] << @guess
      else
        @response = "You're too high!"
        session[:guess_counter] << @guess
      end
    end

  end
  # Resets the game
  def reset
    @guess = nil
    @response = ""
    @rand = nil
    session[:guess_counter] = []
    session[:username] = nil
    session[:rand] = nil
    redirect_to "/game"
  end
end
