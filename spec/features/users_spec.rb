require 'rails_helper'

RSpec.feature "Users", type: :feature do

  let(:root)      { User.new(role: :root, name: "Root", email: "root@example.com", password: '123456') }
  let(:admin)     { User.new(role: :admin, name: "Admin", email: "admin@example.com", password: '123456') }
  let(:secretary) { User.new(role: :secretary, name: "Secretary", email: "secretary@example.com", password: '123456') }

  before :each do
    root.save
    admin.save
    secretary.save
  end

  context 'index' do
    it 'as root' do
      login root
      visit rails_admin.index_path(model_name: 'user')
      expect(page).to have_selector('table tbody tr.user_row', count: 3)
    end

    it 'as admin' do
      login admin
      visit rails_admin.index_path(model_name: 'user')
      expect(page).to have_selector('table tbody tr.user_row', count: 2)
    end

    it 'as secretary' do
      login secretary
      visit rails_admin.index_path(model_name: 'user')
      expect(page).to have_content('You are not authorized to access this page.')
    end
  end

  context 'new' do
    it 'as root' do
      login root
      visit rails_admin.new_path(model_name: 'user')
      expect(page).to have_selector('select#user_role', visible: true,
        text: I18n.t('activerecord.attributes.user.role_enum.root'))

      create_user
    end

    it 'as admin' do
      login root
      visit rails_admin.new_path(model_name: 'user')
      expect(page).to have_selector('select#user_role', visible: false,
        text: I18n.t('activerecord.attributes.user.role_enum.root'))

      create_user
    end
  end

  context 'edit' do
    it 'as root' do
      login root
      visit rails_admin.edit_path(model_name: 'user', id: root.id)
      expect(page).to have_selector('select#user_role', visible: true,
        text: I18n.t('activerecord.attributes.user.role_enum.root'))

      edit_user
    end

    it 'as admin' do
      login admin
      visit rails_admin.edit_path(model_name: 'user', id: admin.id)
      expect(page).not_to have_selector('select#user_role',
        text: I18n.t('activerecord.attributes.user.role_enum.root'))

      edit_user
    end
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

  def create_user
    fill 'name', 'User'
    fill 'email', 'user@example.com'
    fill 'password', '123456'
    fill 'password_confirmation', '123456'
    select I18n.t('activerecord.attributes.user.role_enum.admin'), from: 'user_role'
    click_button I18n.t('admin.form.save')

    expect(page).to have_content(I18n.t('admin.flash.successful',
      name: I18n.t('activerecord.models.user.one'), action: I18n.t("admin.actions.new.done")))
  end

  def edit_user
    click_button I18n.t('admin.form.save')

    expect(page).to have_content(I18n.t('admin.flash.successful',
      name: I18n.t('activerecord.models.user.one'), action: I18n.t("admin.actions.edit.done")))
  end

  def fill field, value
    fill_in I18n.t("activerecord.attributes.user.#{field}"), with: value
  end

end
