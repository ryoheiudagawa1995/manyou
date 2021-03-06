require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end
  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(title: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
  end
  context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(title: 'task', content: 'test', status: '未着手')
      Task.create(title: 'sample', content: 'test', status: '未着手')
    end
    it 'scopeメソッドでタイトル検索ができる' do
      expect(Task.search('task', '').count).to eq 1
    end
    it 'scopeメソッドでステータス検索ができる' do
      expect(Task.search('', '未着手').count).to eq 2
    end
    it 'scopeメソッドでタイトルとステータスの両方が検索できる' do
      expect(Task.search('task', '未着手').count).to eq 1
    end
  end
end
