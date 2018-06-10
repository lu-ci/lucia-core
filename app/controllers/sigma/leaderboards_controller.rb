module Sigma
  class LeaderboardsController < ApplicationController
    InvalidLeaderboard = Class.new(StandardError)

    rescue_from InvalidLeaderboard do |e|
      render json: { error: e.message }, status: 422
    end

    def show
      @scores = scores(params[:id])
    end

  private

    def scores(board)
      res =
        case board
        when "currency" then CurrencySystem
        when "experience" then ExperienceSystem
        when "cookies" then Cookie
        else raise InvalidLeaderboard, %{No leaderboard named "#{board}"}
        end
      res.all.sort(score: -1).limit(20) if res
    end
  end
end
