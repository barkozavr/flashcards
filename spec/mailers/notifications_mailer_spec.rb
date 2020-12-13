require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }
  let!(:mail) { NotificationsMailer.pending_cards(user).deliver_now }

  it 'renders the subject' do
    expect(mail.subject).to eq I18n.t('mail.subject')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['example@gmail.com'])
  end
end
