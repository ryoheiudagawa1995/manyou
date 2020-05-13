require 'rails_helper'

RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
    new_user = FactoryBot.create(:user)
  end
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'sample1'
        fill_in 'user[email]', with: 'sample1@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_on '登録する'
        expect(page).to have_content 'sample1のページ'
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
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        expect(page).to have_content 'sample@example.com'
      end
      it '自分の詳細画面(マイページ)に飛べること' do
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        expect(page).to have_content 'sampleのページ'
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit user_path(id: 2)
        expect(current_path).to eq tasks_path
      end
      it 'ログアウトができること' do
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
        fill_in 'user[name]', with: 'sample2'
        fill_in 'user[email]', with: 'sample2@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_on '登録する'
        expect(page).to have_content 'sample2'
      end
      it '管理者はユーザの詳細画面にアクセスできること' do
        visit tasks_path
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit admin_users_path
        sleep 0.5
        find(:xpath, '/html/body/div/table/tbody/tr[1]/td[5]/a').click
        sleep 0.5
        expect(current_path).to eq admin_user_path(id: 1)
      end
      it '管理者はユーザの編集画面からユーザを編集できること' do
        visit tasks_path
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit admin_users_path
        sleep 0.5

        find(:xpath, '/html/body/div/table/tbody/tr[1]/td[6]/a').click
        sleep 0.5
        expect(current_path).to eq edit_admin_user_path(id: 1)
      end
      it '管理者はユーザの削除をできること' do
        visit tasks_path
        new_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit admin_users_path
        # binding.irb
        # destroy_list = all('.destroy') # タスク一覧を配列として取得するため、View側でidを振っておく
        find(:xpath, '/html/body/div/table/tbody/tr[1]/td[7]/a').click # click_on destroy_list[1]
        expect(User.count).not_to eq 1
      end
    end
  end
end
