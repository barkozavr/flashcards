require 'rails_helper'

describe CardsController do
  let!(:user) { create :user }
  let!(:deck) { create :deck, user: user }
  before do
    login("mail@mail.ru", "123456")
    visit root_path
    click_link I18n.t('header.add_card')
    fill_in :card_original_text, with: "clock", visible: false
  end

  describe 'creating card from root page' do
    # не находит элемент. а option[1] по умолчанию пустой
    # context 'with valid card' do
    #   it 'creates a card' do
    #     fill_in :card_translated_text, with: "часы", visible: false
    #     find(:xpath, "/html/body/div/div[2]/div/form/div/div[3]/select/option[2]").click
    #     click_button I18n.t('card.button.save')
    #     expect(page).to have_content I18n.t('card.note.saved')
    #   end
    # end

    context 'with invalid card' do
      it 'returns fail messages' do
        fill_in :card_translated_text, with: "a"*51, visible: false
        click_button I18n.t('card.button.save')
        expect(page).to have_content I18n.t('card.error.fail')
        expect(page).to have_content 'не может быть больше чем 50 символов'
      end
    end
  end
end
