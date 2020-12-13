# frozen_string_literal: true

class NotificationsMailer < ApplicationMailer
  def pending_cards(user)
    @user = user
    @url = Settings.root_url
    mail(to: user.email, subject: I18n.t('mail.subject'))
  end
end
