# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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
