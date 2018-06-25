# frozen_string_literal: true

class MatchesController < ApplicationController
  def index
    @user = User.where.not(id: current_user.id).order(Arel.sql("RANDOM()")).first
  end

  def create
    @user_a = current_user
    @user_b = User.find(params[:other_user_id])

    if @match = Match.swipe_right(@user_a, @user_b)
      render json: { match: true }
    else
      render json: { match: false }
    end
  end

  def show
    @match = Match.find(params[:id])
  end

private

end
