# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authentication, type: :model do
  describe 'assotiations' do
    it { should belong_to(:user) }
  end
end
