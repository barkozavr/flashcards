require 'rails_helper'

describe TestersController, type: :controller do
  let!(:user) { create :user }
  let(:deck) { create :deck, user: user }
  let!(:card) { create :card, deck: deck }

  before do
    login_user(user)
  end

  describe 'GET index' do
    before do
      get :index, params: { id: card.id }
    end

    it 'returns a 200 OK status' do
      expect(response).to have_http_status 200
    end

    it 'renders index template' do
      expect(response).to render_template :index
    end
  end

  describe 'POST create' do
    context 'when answer is true' do
      it 'redirect to testers_path' do
        post :create, params: { card_id: card.id, answer: 'transponder' }
        expect(flash[:info]).to eq I18n.t('card.note.it_true')
        expect(response).to redirect_to testers_path
      end
    end

    context 'when answer is ftrue' do
      before do
        post :create, params: { card_id: card.id, answer: 'transponder' }
      end
      it 'redirect to testers_path' do
        expect(response).to redirect_to testers_path
      end

      it 'returns flash messages' do
        expect(flash[:info]).to eq I18n.t('card.note.it_true')
      end
    end

    context 'when answer is correct, but with one typo' do
      it 'returns flash messages' do
        post :create, params: { card_id: card.id, answer: 'tranpsonder' }
        expect(flash[:info]).to eq I18n.t('card.note.it_true_with_typo', answ: 'tranpsonder', translate: card.translated_text)
      end
    end

    context 'when answer is false' do
      before do
        post :create, params: { card_id: card.id, answer: 'blalba' }
      end
      it 'redirect to testers_path' do
        expect(response).to redirect_to testers_path
      end

      it 'returns flash messages' do
        expect(flash[:warning]).to eq "Неверно! Осталось 2 попытки."
      end
    end

    context 'with 3 failes' do
      before do
        card.update!(attempt: 2)
      end
      it 'returns flash messages' do
        post :create, params: { card_id: card.id, answer: 'blalba' }
        expect(flash[:danger]).to eq I18n.t('card.note.incorrect_with_reset', translate: card.translated_text)
      end
    end
  end
end
