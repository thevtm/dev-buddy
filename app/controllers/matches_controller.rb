# frozen_string_literal: true

class MatchesController < ApplicationController
  def index
  end


  def create
    @user_a = current_user
    @user_b = User.find(params[:user_id])
    if @match = Match.swipe_right(user_a, user_b)
    else
      #redirect
    end
  end

private


end
