class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index new create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to users_path, notice: t('user.note.created')
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('user.note.updated')
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
