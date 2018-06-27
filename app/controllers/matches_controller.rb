# frozen_string_literal: true

class MatchesController < ApplicationController
  def index
    @user_a = next_match
    @user_b = next_match
  end

  def create
    user_a = current_user
    user_b = User.find(params[:other_user_id])
    is_match = params[:match] == "1"

    user = next_match

    new_match_html = render_to_string(partial: "shared/match", locals: { user: user })

    if is_match
      match = Match.swipe_right(user_a, user_b)
      if match.its_a_match?
        create_chat_room(user_a, user_b)
        render json: { match: true, new_match_html: new_match_html }
      else
        render json: { match: false, new_match_html: new_match_html }
      end
    else
      match = Match.swipe_left(user_a, user_b)
      render json: { match: false, new_match_html: new_match_html }
    end
  end

  def show
    @match = Match.find(params[:id])
  end

private
  def next_match
    if session[:next_match_list].nil? || session[:next_match_list].empty?
      users_already_matched = current_user.matches.all.map(&:user_b_id).push(current_user.id)
      session[:next_match_list] = User.where.not(id: users_already_matched).map(&:id).to_a
    end

    next_user_id = session[:next_match_list].pop
    if next_user_id.nil?
      nil
    else
      User.find(next_user_id)
    end
  end

  def create_chat_room(user_a, user_b)
    chat_room = ChatRoom.create!()

    ChatRoomUser.create!(
      chat_room: chat_room,
      user: user_a,
    )

    ChatRoomUser.create!(
      chat_room: chat_room,
      user: user_b,
    )
  end
end
