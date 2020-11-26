require 'rails_helper'

describe TestersController do
  let(:user) { create :user }
  let(:card) { create :card, user: user }
  before do
    card.update(review_date: Date.today)
    visit root_path
  end

  describe 'POST create' do
    context 'when answer is_true' do
      it 'gets right message ' do
        fill_in :answer, with: "transponder", visible: false
        click_button I18n.t('card.button.check')
        expect(page).to have_content I18n.t('card.note.it_true')
      end
    end

    context 'when answer is_false' do
      it 'gets wrong message' do
        fill_in :answer, with: 'beleberda', visible: false
        click_button I18n.t('card.button.check')
        expect(page).to have_content I18n.t('card.note.it_false')
      end
    end
  end
end
