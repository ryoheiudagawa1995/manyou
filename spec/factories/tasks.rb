FactoryBot.define do
  factory :task do
    title { 'task' }
    limit { Date.new(2020,5,31) }
    status { '未着手' }
    priority { '高' }
    content { 'test_content' }
  end

  factory :second_task, class: Task do
    title { 'new_task' }
    limit { 'test2_limit' }
    status { '完了' }
    priority { '中' }
    content { 'test2_content' }
  end
end
