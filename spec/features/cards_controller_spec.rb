require 'rails_helper'
# написал эти тесты для тренировки ещё до создания модели user. 
# полагаю, будут актуальны после добавления функции входа на сайт
# describe TestersController do
#   describe 'creating card from root page' do
#     before do
#       visit root_path
#       click_link I18n.t('header.add_card')
#       fill_in :card_original_text, with: "clock"
#     end

#     context 'with valid card' do
#       it 'creates a card' do
#         fill_in :card_translated_text, with: "часы"
#         click_button I18n.t('card.button.save')
#         expect(page).to have_content I18n.t('card.note.saved')
#       end
#     end

#     context 'with invalid card' do
#       it 'returns fail messages' do
#         fill_in :card_translated_text, with: "a"*51
#         click_button I18n.t('card.button.save')
#         expect(page).to have_content I18n.t('card.error.fail')
#         expect(page).to have_content 'не может быть больше чем 50 символов'
#       end
#     end
#   end
# end
