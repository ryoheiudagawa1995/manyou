FactoryBot.define do
  factory :label do
    name { "ruby" }
    user_id { 1 }
  end

  factory :second_label, class: Label do
    name { "rails" }
    user_id { 1 }
  end
end
