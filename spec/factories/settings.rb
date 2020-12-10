FactoryBot.define do
  factory :setting do
    notifs { "This is a notification!" }
    public { ["Pronouns", "Status"] }
    dating { false }
  end
end
