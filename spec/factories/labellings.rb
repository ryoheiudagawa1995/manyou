FactoryBot.define do
  factory :labelling_ruby do
    task_id { 1 }
    label_id { 1 }
  end

  factory :labelling_rails do
    task_id { 2 }
    label_id { 2 }
  end
end
