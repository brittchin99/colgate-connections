FactoryBot.define do
  factory :notification do
    profile { "" }
    type { "MyText" }
    content { "MyText" }
    updater { "" }
    read { false }
  end
end
