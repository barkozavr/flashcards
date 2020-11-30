# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(@user, notice: t('user.note.log_in'))
    else
      flash.now[:warning] = t('user.note.log_in_false')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: t('user.note.log_out'))
  end
end
