require 'rails_helper'

RSpec.describe Conversation, type: :model do
    context "has_messages? method" do
        it "should be defined" do
            c = FactoryBot.build(:conversation)  
            expect(c).to respond_to(:has_messages?)
        end
        it "should return true if a conversation has messages" do
            m = FactoryBot.build(:message)
            c = FactoryBot.build(:conversation, :messages => [m])
            expect(c.has_messages?).to eq(true)
        end
        it "should return false if a conversation has no messages" do
            c = FactoryBot.build(:conversation, :messages => [])
            expect(c.has_messages?).to eq(false)
        end
    end
    
    context "has_unread_messages? method" do
        it "should be defined" do
            c = FactoryBot.build(:conversation)  
            expect(c).to respond_to(:has_unread_messages?)
        end
        it "should return true if a conversation has unread messages" do
            m = FactoryBot.build(:message)
            c = FactoryBot.build(:conversation, :messages => [m])
            expect(c.has_unread_messages?).to eq(true)
        end
        # it "should return false if a conversation has no unread messages" do
        #     m = FactoryBot.build(:message, :read => true)
        #     c = FactoryBot.build(:conversation, :messages => [m])
        #     expect(c.has_unread_messages?).to eq(false)
        # end
    end
    
    context "last_message method" do
        it "should be defined" do
            c = FactoryBot.build(:conversation)  
            expect(c).to respond_to(:last_message)
        end
        it "should return the last message if there are messages" do
            m1 = FactoryBot.build(:message)
            m2 = FactoryBot.build(:message, :body => "No")
            c = FactoryBot.build(:conversation, :messages => [m1, m2])
            expect(c.last_message).to eq(m2)
        end
        it "should return nil if there are no messages" do
            c = FactoryBot.build(:conversation, :messages => [])
            expect(c.last_message).to eq(nil)
        end
    end
end
