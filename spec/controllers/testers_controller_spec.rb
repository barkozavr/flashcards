require 'rails_helper'

describe TestersController, type: :controller do
  let(:user) { create :user }
  let(:card) { create :card, user: user }

  before do
    card.update(review_date: Date.today)
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

    context 'when answer is false' do
      it 'redirect to testers_path' do
        post :create, params: { card_id: card.id, answer: 'blalba' }
        expect(flash[:warning]).to eq I18n.t('card.note.it_false')
        expect(response).to redirect_to testers_path
      end
    end
  end
end
