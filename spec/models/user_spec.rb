require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'assotiations' do
    it { should have_many(:cards) }
    it { should have_many(:authentications) }
  end
end
