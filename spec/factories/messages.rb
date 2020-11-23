FactoryBot.define do
  factory :message do
    body { "MyText" }
    conversation { nil }
    account { nil }
    read { false }
  end
end
