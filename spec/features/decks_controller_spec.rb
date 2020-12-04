# frozen_string_literal: true

require 'rails_helper'

describe CardsController do
  let!(:user) { create :user }
  before do
    login("mail@mail.ru", "123456")
    visit root_path
    click_link I18n.t('deck.page.add')
  end

  describe 'creating deck from root page' do
    context 'with valid deck' do
      it 'creates a deck' do
        fill_in :deck_name, with: "new_deck", visible: false
        click_button I18n.t('card.button.save')
        expect(page).to have_content I18n.t('deck.note.created')
      end
    end

    context 'with invalid deck' do
      it 'returns fail messages' do
        fill_in :deck_name, with: nil, visible: false
        click_button I18n.t('card.button.save')
        expect(page).to have_content I18n.t('card.error.fail')
        expect(page).to have_content 'Name не может быть пустым'
      end
    end

    context 'when deck with current: true already exists' do
      let!(:deck) { create :deck, user: user }
      it 'returns fail messages' do
        fill_in :deck_name, with: "valid name", visible: false
        find(:xpath, '//*[@id="deck_current"]').click
        click_button I18n.t('card.button.save')
        expect(page).to have_content I18n.t('card.error.fail')
        expect(page).to have_content 'Current уже существует'
      end
    end
  end
end
