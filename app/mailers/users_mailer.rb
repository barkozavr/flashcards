class UsersMailer < ApplicationMailer
  def user_created(user)
    @user = user
    mail(to: user.email, subject: I18n.t('mail.welcome'))
  end
end
