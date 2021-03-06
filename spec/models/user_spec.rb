require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validation tests' do
    it 'ensures name presence' do
      user = User.new status: :active, role: :admin, email: 'example@example.com', password: '123456'
      expect(user.valid?).to eq(false)
    end

    it 'ensures email presence' do
      user = User.new name: 'Example', status: :active, role: :admin, password: '123456'
      expect(user.valid?).to eq(false)
    end

    it 'ensures password presence' do
      user = User.new name: 'Example', status: :active, role: :admin, email: 'example@example.com'
      expect(user.valid?).to eq(false)
    end

    it 'ensure password has correct length' do
      user = User.new name: 'Example', status: :active, role: :admin, email: 'example@example.com', password: '12345'
      expect(user.valid?).to eq(false)

      # https://stackoverflow.com/questions/88311/how-to-generate-a-random-string-in-ruby
      random_password = (0...129).map{('a'..'z').to_a[rand(&:to_a)]}.join
      user.password = random_password
      expect(user.valid?).to eq(false)
    end

    it 'ensures role presence' do
      user = User.new name: 'Example', status: :active, email: 'example@example.com', password: '123456'
      expect(user.valid?).to eq(false)
    end

    it 'ensures no need to specify status' do
      user = User.new name: 'Example', role: :admin, email: 'example@example.com', password: '123456'
      expect(user.valid?).to eq(true)
    end

    it 'ensure presence of all required fields' do
      user = User.new name: 'Example', status: :active, role: :admin, email: 'example@example.com', password: '123456'
      expect(user.valid?).to eq(true)
    end

    it 'uniqueness of email' do
      u1 = User.create name: 'User1', role: :admin, email: 'example@example.com', password: '123456'
      u2 = User.create name: 'User2', role: :secretary, email: 'example@example.com', password: '654321'
      expect(User.count).to eq(1)
    end
  end

end
