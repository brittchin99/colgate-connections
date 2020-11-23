FactoryBot.define do
  factory :message do
    body { "Okay!" }
    conversation { nil }
    profile { nil }
    read { false }
  end
end
