require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }
  describe 'GET index' do
    before do
      get :index
    end

    it 'returns a 200 OK status' do
      expect(response).to have_http_status 200
    end

    it 'renders index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET new' do
    before { get :new }

    it 'returns a 200 OK status' do
      expect(response).to have_http_status 200
    end

    it 'renders show template' do
      expect(response).to render_template :new
    end
  end

  describe 'GET show' do
    context 'not signed in' do
      before { get :show, params: { id: user.id } }

      it 'renders show template' do
        expect(response).to redirect_to login_path
      end
    end

    context 'signed in' do
      before do
        login_user(user)
        get :show, params: { id: user.id }
      end

      it 'renders show template' do
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET edit' do
    context 'not signed in' do
      before { get :edit, params: { id: user.id } }

      it 'renders show template' do
        expect(response).to redirect_to login_path
      end
    end

    context 'signed in' do
      before do
        login_user(user)
        get :edit, params: { id: user.id }
      end

      it 'renders edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST create' do
    context 'with valid user' do
      it 'creates a user' do
        expect { post :create, params: { user: attributes_for(:user, :valid) } }.to change(User, :count).by(1)
      end

      it 'redirects to user page' do
        post :create, params: { user: attributes_for(:user, :valid) }
        expect(response).to redirect_to users_path
      end
    end

    context 'with invalid user' do
      it "won't create a user" do
        expect { post :create, params: { user: attributes_for(:user, :invalid) } }.to_not change(User, :count)
      end

      it 'renders new template' do
        post :create, params: { user: attributes_for(:user, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    before do
      login_user(user)
    end
    let(:new_user_params) do
      { email: 'new_mail@mail.com', password: 'password', password_confirmation: 'password' }
    end

    context 'valid params' do
      it 'redirects to users page' do
        put :update, params: { id: user.id, user: new_user_params }
        expect(response).to redirect_to user_url(user)
      end

      it 'updates user' do
        put :update, params: { id: user.id, user: new_user_params }
        user.reload
        expect(user.email).to eq new_user_params[:email]
      end
    end

    context 'invalid params' do
      let(:invalid_attr) do
        { email: nil, password: 'password', password_confirmation: 'password' }
      end

      before do
        put :update, params: { id: user.id, user: invalid_attr }
      end

      it 'renders edit page' do
        expect(response).to render_template :edit
      end

      it 'user not updated' do
        user.reload
        expect(user).to eq user
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:valid_user) { create :user, :valid }
    before do
      login_user(user)
    end
    it 'destroys user' do
      expect do
        delete :destroy, params: { id: valid_user.id }
      end.to change(User, :count).by(-1)
    end

    it 'redirects to card index page' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to root_path
    end
  end
end
