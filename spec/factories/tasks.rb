FactoryBot.define do
  factory :task do
    title { 'task' }
    limit { 'test_limit' }
    status { 'test_status' }
    priority { 'test_priority' }
    content { 'test_content' }
  end

  factory :second_task, class: Task do
    title { 'new_task' }
    limit { 'test2_limit' }
    status { 'test2_status' }
    priority { 'test2_priority' }
    content { 'test2_content' }
  end
end
