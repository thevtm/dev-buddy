# frozen_string_literal: true

class MatchesController < ApplicationController
  def index
  end


  def create
    @user_a = current_user
    @user_b = User.find(params[:match][:user_b_id])
    if @match = Match.swipe_right(@user_a, @user_b)
      redirect_to user_match_path(current_user, @match)
    else
      next_user = User.where.not(id: current_user.id).order(Arel.sql("RANDOM()")).first
      redirect_to user_path(next_user)
    end
  end

  def show
    @match = Match.find(params[:id])
  end

private


end
