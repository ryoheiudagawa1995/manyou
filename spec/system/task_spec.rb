require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    before do
      @task = FactoryBot.create(:task)
    end
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        new_task = FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('#task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが終了期限の昇順に並んでいる' do
        visit new_task_path
        fill_in 'Title', with: 'タスク'
        fill_in 'Content', with: 'コンテンツ'
        fill_in 'Limit', with: Date.new(2020,6,30)
        click_on '登録する'
        visit tasks_path
        click_on '終了期限でソートする'
        task_list = all('#limit_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content Date.new(2020,5,31)
        expect(task_list[1]).to have_content Date.new(2020,6,30)
      end
      it 'タスクが優先順位の昇順に並んでいる' do
        visit new_task_path
        fill_in 'Title', with: 'タスク'
        fill_in 'Content', with: 'コンテンツ'
        fill_in 'Limit', with: Date.new(2020,6,30)
        select '完了', from: 'status'
        select '低', from: 'priority'
        click_on '登録する'
        visit tasks_path
        click_on '優先順位でソートする'
        task_list = all('#priority_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '低'
      end
    end
    context 'scopeメソッドで検索をした場合' do
      it "scopeメソッドでタイトルで検索できる" do
        new_task = FactoryBot.create(:second_task)
        visit tasks_path
        fill_in 'title_search', with: 'task'
        click_on "search"
      expect(page).to have_content 'task'
      end
      it "scopeメソッドでstatusで検索できる" do
        new_task = FactoryBot.create(:second_task)
        visit tasks_path
        select '未着手', from: :status_search
        click_on "search"
      expect(page).to have_content '未着手'
      end
      it "scopeメソッドでタイトルとstatusで検索できる" do
        new_task = FactoryBot.create(:second_task)
        visit tasks_path
        fill_in 'title_search', with: 'task'
        select '未着手', from: :status_search
        click_on "search"
      expect(page).to have_content 'task', '未着手'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'Title', with: 'タスク'
        fill_in 'Content', with: 'コンテンツ'
        click_on '登録する'
        expect(page).to have_content 'content', 'コンテンツ'
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        task = FactoryBot.create(:task)
        visit tasks_path
        click_on 'Show'
        expect(page).to have_content 'title', 'task'
      end
    end
  end
end
