require 'rails_helper'
require 'time'

RSpec.describe Message, type: :model do
    context " message_time method" do
        it "should be defined" do
            m = FactoryBot.build(:message)  
            expect(m).to respond_to(:message_time)
        end
        it "should return the correct time" do
            t = Time.parse("Nov 22 23:15:00 2020 UTC")
            m = FactoryBot.build(:message, :created_at => t) 
            expect(m.message_time).to eq("11/22/20 at  6:15 PM")
        end
    end
end
