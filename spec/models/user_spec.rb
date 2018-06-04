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

    it 'password has incorrect length' do
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

    it 'ensures status presence' do
      user = User.new name: 'Example', role: :admin, email: 'example@example.com', password: '123456'
      expect(user.valid?).to eq(false)
    end

    it 'ensure presence of all required fields' do
      user = User.new name: 'Example', status: :active, role: :admin, email: 'example@example.com', password: '123456'
      expect(user.valid?).to eq(true)
    end

  end

end
