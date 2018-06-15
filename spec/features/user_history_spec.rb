require 'rails_helper'

RSpec.feature "User history", type: :feature do

  let(:root)      { User.new(role: :root, name: "Root", email: "root@example.com", password: '123456') }
  let(:admin)     { User.new(role: :admin, name: "Admin", email: "admin@example.com", password: '123456') }
  let(:secretary) { User.new(role: :secretary, name: "Secretary", email: "secretary@example.com", password: '123456') }

  before :each do
    root.save
    admin.save
    secretary.save
  end

  it 'root can view all user histories' do
    login root

    visit rails_admin.history_index_path(model_name: 'user')
    expect(page).to have_content(root.name)
    expect(page).to have_content(admin.name)
    expect(page).to have_content(secretary.name)
  end

  it 'admin cannot view root history' do
    login admin

    visit rails_admin.history_index_path(model_name: 'user')
    expect(page).not_to have_content(root.name)
    expect(page).to have_content(admin.name)
    expect(page).to have_content(secretary.name)
  end

  it 'secretary cannot access user history path' do
    login secretary

    visit rails_admin.history_index_path(model_name: 'user')
    expect(page).to have_content('You are not authorized to access this page.')
  end

  # ----- HELPER METHODS ----- #

  def login user
    visit ''
    within('#new_user') do
      fill_in I18n.t('login.placeholder.email'), with: user.email
      fill_in I18n.t('login.placeholder.password'), with: user.password
    end
    click_button 'Login'
    expect(current_path).to eq rails_admin.dashboard_path
  end

end
