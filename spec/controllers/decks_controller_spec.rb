# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DecksController, type: :controller do
  let!(:user) { create :user }
  let(:deck) { create :deck, user: user }
  before { login_user(user) }

  describe 'GET index' do
    before { get :index, params: { id: deck.id } }

    it 'returns a 200 OK status' do
      expect(response).to have_http_status 200
    end

    it 'renders index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET show' do
    before { get :show, params: { id: deck.id } }

    it 'renders show template' do
      expect(response).to render_template :show
    end

    it 'returns success status' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET new' do
    before { get :new }

    it 'renders new template' do
      expect(response).to render_template :new
    end

    it 'returns success status' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST create' do
    context 'with valid deck' do
      it 'creates a deck' do
        expect do
          post :create, params: { deck: { name: "newest deck" } }
        end.to change(Deck, :count).by(1)
      end

      it 'redirects to index page' do
        post :create, params: { deck: { name: "super newest deck" } }
        expect(response).to redirect_to decks_path
      end
    end

    context 'with invalid deck' do
      it "won't create a deck" do
        expect do
          post :create, params: { deck: { name: nil } }
        end.to_not change(Deck, :count)
      end

      it 'renders new template' do
        post :create, params: { deck: { name: nil } }
        expect(response).to render_template :new
      end
    end

    context 'when deck with cuurrent: true already exists' do
      let!(:deck) { create :deck, user: user }
      it "won't create a deck" do
        expect do
          post :create, params: { deck: { name: "valid deck name", current: true } }
        end.to_not change(Deck, :count)
        expect(response).to render_template :new
        expect(flash[:warning]).to eq I18n.t('card.error.fail')
      end
    end
  end

  describe 'GET edit' do
    before { get :edit, params: { id: deck.id } }

    it 'renders edit template' do
      expect(response).to render_template :edit
    end

    it 'returns success status' do
      expect(response.status).to eq 200
    end
  end

  describe 'PUT update' do
    let(:new_params) do
      { name: 'new name of deck' }
    end

    context 'with valid params' do
      it 'redirects to deck page' do
        put :update, params: { id: deck.id, deck: new_params }
        expect(response).to redirect_to decks_path
      end

      it 'updates deck' do
        put :update, params: { id: deck.id, deck: new_params }
        deck.reload
        expect(deck.name).to eq new_params[:name]
      end
    end

    context 'with invalid params' do
      let(:invalid_attr) do
        { name: nil }
      end

      before do
        put :update, params: { id: deck.id, deck: invalid_attr }
      end

      it 'renders edit page' do
        expect(response).to render_template :edit
      end

      it 'deck not updated' do
        deck.reload
        expect(deck).to eq deck
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:deck) { create :deck, user: user }
    it 'destroys deck' do
      expect do
        delete :destroy, params: { id: deck.id }
      end.to change(Deck, :count).by(-1)
    end

    it 'redirects to deck index page' do
      delete :destroy, params: { id: deck.id }
      expect(response).to redirect_to(decks_path)
    end
  end
end
