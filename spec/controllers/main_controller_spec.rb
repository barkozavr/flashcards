require 'rails_helper'

describe MainController do
  describe 'index action' do
    it 'returns a 200 OK status' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
