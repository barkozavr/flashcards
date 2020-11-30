# frozen_string_literal: true

class OauthsController < ApplicationController
  skip_before_action :require_login
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, notice: "#{t('user.note.logged_from')} #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session
        auto_login(@user)
        redirect_to root_path, notice: "#{t('user.note.logged_from')} #{provider.titleize}!"
      rescue StandardError
        redirect_to root_path, alert: "#{t('user.alert.failed_from')} #{provider.titleize}!"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
