FactoryBot.define do
  factory :conversation do
    sender_id { 1 }
    receiver_id { 2 }
    messages = nil
  end
end
