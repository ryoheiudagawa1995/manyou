require 'rails_helper'

RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'sample'
        fill_in 'user[email]', with: 'sample@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_on '登録する'
        expect(page).to have_content 'sampleのページ'
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ログインができること' do
        new_user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        expect(page).to have_content 'sample@example.com'
      end
      it '自分の詳細画面(マイページ)に飛べること' do
        new_user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        expect(page).to have_content 'sampleのページ'
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        new_user = FactoryBot.create(:user)
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit user_path(id: 2)
        expect(current_path).to eq tasks_path
      end
      it 'ログアウトができること' do
        new_user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        click_on 'Logout'
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe '管理画面のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it '管理者は管理画面にアクセスできること' do
        new_user = FactoryBot.create(:user)
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content '管理画面のユーザー一覧画面だよ！'
      end
      it '一般ユーザは管理画面にアクセスできないこと' do
        visit tasks_path
        new_user = FactoryBot.create(:user)
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit admin_users_path
        expect(current_path).to eq new_session_path
      end
      it '管理者はユーザを新規登録できること' do
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit admin_users_path
        click_on 'New'
        fill_in 'user[name]', with: 'sample'
        fill_in 'user[email]', with: 'sample@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_on '登録する'
        expect(page).to have_content 'sample'
      end
      it '管理者はユーザの詳細画面にアクセスできること' do
        visit tasks_path
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit admin_users_path
        click_on 'show'
        expect(current_path).to eq admin_user_path(id: 2)
      end
      it '管理者はユーザの編集画面からユーザを編集できること' do
        visit tasks_path
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit admin_users_path
        click_on 'Edit'
        expect(current_path).to eq edit_admin_user_path(id: 2)
      end
      it '管理者はユーザの削除をできること' do
        visit tasks_path
        new_user = FactoryBot.create(:user)
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit admin_users_path
        click_on 'Destroy'
        expect(current_path).to eq edit_admin_user_path(id: 2)
      end
    end
  end
end
