# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def setting
    @user = current_user
    render "setting"
  end

  def profile
    @user = current_user
    render "show"
  end
end
