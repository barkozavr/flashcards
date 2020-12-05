class ApplicationController < ActionController::Base
  before_action :require_login, except: [:not_authenticated]

  private

  def not_authenticated
    redirect_to login_path
    flash[:warning] = t('user.alert.log_in_first')
  end
end
