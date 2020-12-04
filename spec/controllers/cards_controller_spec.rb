require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let!(:user) { create :user }
  let(:deck) { create :deck, user: user }
  let(:card) { create :card, deck: deck }
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

  describe 'GET show' do
    before do
      get :show, params: { id: card.id }
    end

    it 'renders show template' do
      expect(response).to render_template :show
    end

    it 'returns success status' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET new' do
    before do
      get :new
    end

    it 'renders new template' do
      expect(response).to render_template :new
    end

    it 'returns success status' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST create' do
    context 'with valid card' do
      it 'creates a card' do
        expect do
          post :create, params: { card: { deck_id: deck.id, original_text: 'o1', translated_text: 't1' } }
        end.to change(Card, :count).by(1)
      end

      it 'redirects to show page' do
        post :create, params: { card: { deck_id: deck.id, original_text: 'o2', translated_text: 't2' } }
        expect(response).to redirect_to cards_path
      end
    end

    context 'with invalid card' do
      it "won't create a card" do
        expect do
          post :create, params: { card: { deck_id: deck.id, original_text: 'o2', translated_text: nil } }
        end.to_not change(Card, :count)
      end

      it 'renders new template' do
        post :create, params: { card: { deck_id: deck.id, original_text: 'o2', translated_text: nil } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: card.id }
    end

    it 'renders edit template' do
      expect(response).to render_template :edit
    end

    it 'returns success status' do
      expect(response.status).to eq 200
    end
  end

  describe 'PUT update' do
    let(:new_params) do
      { original_text: 'or edited', translated_text: 'tr edited' }
    end

    context 'valid params' do
      it 'redirects to card page' do
        put :update, params: { id: card.id, card: new_params }
        expect(response).to redirect_to card_url(card)
      end

      it 'updates card' do
        put :update, params: { id: card.id, card: new_params }
        card.reload
        expect(card.original_text).to eq new_params[:original_text]
        expect(card.translated_text).to eq new_params[:translated_text]
      end
    end

    context 'invalid params' do
      let(:invalid_attr) do
        { original_text: nil }
      end

      before do
        put :update, params: { id: card.id, card: invalid_attr }
      end

      it 'renders edit page' do
        expect(response).to render_template :edit
      end

      it 'card not updated' do
        card.reload
        expect(card).to eq card
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:card) { create :card, deck: deck }
    it 'destroys card' do
      expect do
        delete :destroy, params: { id: card.id }
      end.to change(Card, :count).by(-1)
    end

    it 'redirects to card index page' do
      delete :destroy, params: { id: card.id }
      expect(response).to redirect_to(cards_path)
    end
  end
end
