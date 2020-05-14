FactoryBot.define do
  factory :label do
    name { "ruby" }
  end

  factory :second_label, class: Label do
    name { "rails" }
  end
end
