require 'rails_helper'

RSpec.describe User, type: :model do
  subject :user do
    User.new
  end

  context 'validation tests' do
    it 'ensures email presence' do
      expect(user.valid?).to eq(false)
    end
  end

end
