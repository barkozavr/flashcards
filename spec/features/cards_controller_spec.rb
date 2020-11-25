require 'rails_helper'

describe TestersController do
  describe 'creating card from root page' do
    before do
      visit root_path
      click_link I18n.t('header.add_card')
      fill_in :card_original_text, with: "clock"
    end

    context 'with valid card' do
      it 'creates a card' do
        fill_in :card_translated_text, with: "часы"
        click_button I18n.t('card.button.save')
        expect(page).to have_content I18n.t('card.note.saved')
      end
    end

    context 'with invalid card' do
      it 'returns fail messages' do
        fill_in :card_translated_text, with: "a"*51
        click_button I18n.t('card.button.save')
        expect(page).to have_content I18n.t('card.error.fail')
        # я хз, нужно ли проверять сообщения ошибок от simple_form.
        # Как их найти и как к ним обращатья с помощью I18n я пока что тоже не разобрался. Так что вот:
        # (работает)
        expect(page).to have_content 'не может быть больше чем 50 символов'
      end
    end
  end
end
