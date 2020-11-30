# frozen_string_literal: true

require 'rails_helper'

describe UserSessionsController, type: :controller do
  let(:user) { create :user }

  describe 'GET new' do
    before do
      get :new
    end

    it 'returns a 200 OK status' do
      expect(response).to have_http_status 200
    end

    it 'renders index template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'login with correct email and password' do
      before do
        post :create, params: { email: user.email, password: '123456' }
      end

      it 'user logged in' do
        expect(flash[:notice]).to eq I18n.t('user.note.log_in')
        expect(logged_in?).to eq true
      end

      it 'redirects to main page' do
        is_expected.to redirect_to user_path(user)
      end
    end

    context 'login with incorrect email and password' do
      before do
        post :create, params: { user_login: { email: user.email, password: '000000' } }
      end

      it 'user not logged in' do
        expect(flash[:warning]).to eq I18n.t('user.note.log_in_false')
        expect(logged_in?).to eq false
      end

      it 'renders template' do
        is_expected.to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login_user(user)
      delete :destroy, params: { id: user.id }
    end

    it 'session is destroyed' do
      expect(flash[:notice]).to eq I18n.t('user.note.log_out')
      expect(logged_in?).to eq false
    end

    it 'redirects to main page' do
      is_expected.to redirect_to users_path
    end
  end
end
