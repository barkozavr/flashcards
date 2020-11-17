require 'rails_helper'

RSpec.describe CardsController,  type: :controller do
  let!(:card) { create :card }

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

    it 'renders template' do
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

    it 'renders template' do
      expect(response).to render_template :new
    end

    it 'returns success status' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST create' do
    context 'with valid card' do
      it 'creates a card' do
        expect { post :create, params: { card: attributes_for(:card) } }.to change(Card, :count).by(1)
      end

      it 'redirects to show page' do
        post :create, params: { card: attributes_for(:card) }
        expect(response).to redirect_to cards_path
      end
    end

    context 'with invalid card' do
      it "won't create a card" do
        expect { post :create, params: { card: attributes_for(:invalid_card) } }.to_not change(Card, :count)
      end

      it 'renders :new' do
        post :create, params: { card: attributes_for(:invalid_card) }
        expect(response).to render_template :new
      end
    end
  end
end
