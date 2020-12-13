# frozen_string_literal: true

class NotificationsMailerPreview < ActionMailer::Preview
  def pending_cards
    NotificationsMailer.pending_cards(User.first)
  end
end
