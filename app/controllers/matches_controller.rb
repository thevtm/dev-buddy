# frozen_string_literal: true

class MatchesController < ApplicationController
  def index
    random_users = User.where.not(id: current_user.id).order(Arel.sql("RANDOM()")).limit(2)
    @user_a = random_users[0]
    @user_b = random_users[1]
  end

  def create
    user_a = current_user
    user_b = User.find(params[:other_user_id])
    is_match = params[:match] == "1"

    user = new_random_match

    new_match_html = render_to_string(partial: "shared/match", locals: { user: user })

    if is_match
      if Match.swipe_right(user_a, user_b)
        render json: { match: true, new_match_html: new_match_html }
      else
        render json: { match: false, new_match_html: new_match_html }
      end
    else
      render json: { match: false, new_match_html: new_match_html }
    end
  end

  def show
    @match = Match.find(params[:id])
  end

private
  def new_random_match
    User.where.not(id: current_user.id).order(Arel.sql("RANDOM()")).first
  end
end
