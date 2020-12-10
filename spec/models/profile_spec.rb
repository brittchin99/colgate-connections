require 'rails_helper'

RSpec.describe Profile, type: :model do
    context "connected_to method" do
        it "should be defined" do
            a = FactoryBot.build(:profile)  
            expect(a).to respond_to(:connected_to)
        end
        it "should return true if two accounts are connected" do
            p1 = FactoryBot.create(:profile)
            a2 = FactoryBot.create(:account, :id => 2, :email => "ptnguyen@colgate.edu", :password => "colgate13")
            p2 = FactoryBot.create(:profile, :account => a2, :first_name => "Amber", :last_name => "Nguyen")
            c = FactoryBot.create(:connection, :profile => p1, :friend => p2)
            expect(p1.connected_to(p2)).to eq(true)
          end
      
        it "should return false if two accounts are not connected" do
            p1 = FactoryBot.create(:profile)
            a2 = FactoryBot.create(:account, :id => 2, :email => "ptnguyen@colgate.edu", :password => "colgate13")
            p2 = FactoryBot.create(:profile, :account => a2, :first_name => "Amber", :last_name => "Nguyen")
            expect(p1.connected_to(p2)).to eq(false)
        end
    end
    
    context "pending_friend_request? method" do
        it "should be defined" do
            a = FactoryBot.build(:profile)  
            expect(a).to respond_to(:pending_friend_request?)
        end
        it "should return true if one account has a pending friend request from another" do
            p1 = FactoryBot.create(:profile)
            a2 = FactoryBot.create(:account, :id => 2, :email => "ptnguyen@colgate.edu", :password => "colgate13")
            p2 = FactoryBot.create(:profile, :account => a2, :first_name => "Amber", :last_name => "Nguyen")
            fr = FactoryBot.create(:friend_request, :profile => p1, :friend => p2)
            expect(p1.pending_friend_request?(p2)).to eq(true)
          end
      
        it "should return false if one account does not have a pending friend request from another" do
            p1 = FactoryBot.create(:profile)
            a2 = FactoryBot.create(:account, :id => 2, :email => "ptnguyen@colgate.edu", :password => "colgate13")
            p2 = FactoryBot.create(:profile, :account => a2, :first_name => "Amber", :last_name => "Nguyen")
            expect(p1.pending_friend_request?(p2)).to eq(false)
        end
    end
    context "blocking method" do
        it "should be defined" do
            a = FactoryBot.build(:profile)  
            expect(a).to respond_to(:blocking)
        end
        it "should return true if one account blocks another" do
            p1 = FactoryBot.create(:profile)
            a2 = FactoryBot.create(:account, :id => 2, :email => "ptnguyen@colgate.edu", :password => "colgate13")
            p2 = FactoryBot.create(:profile, :account => a2, :first_name => "Amber", :last_name => "Nguyen")
            b = FactoryBot.create(:blockage, :profile => p1, :blockee => p2)
            expect(p1.blocking(p2)).to eq(true)
          end
      
        it "should return false if one account does not block another" do
            p1 = FactoryBot.create(:profile)
            a2 = FactoryBot.create(:account, :id => 2, :email => "ptnguyen@colgate.edu", :password => "colgate13")
            p2 = FactoryBot.create(:profile, :account => a2, :first_name => "Amber", :last_name => "Nguyen")
            expect(p1.blocking(p2)).to eq(false)
        end
    end
    context "toList method" do
        it "should be defined" do
            expect(Profile).to respond_to(:toList)
        end
        it "should return an empty array if the string representation is blank" do
            expect(Profile.toList("")).to eq([])
        end
      
        it "should return an array of 1 item if the string representation doesn't contain square brackets" do
            s = "Computer Science"
            expect(Profile.toList(s)).to eq([s])
        end
        
        it "should return have the correct number of items" do
            s = "[\"Computer Science\", \"Asian Studies\"]"
            expect(Profile.toList(s).length).to eq(2)
        end
    end
    
    context "has_conversation_with method" do
        it "should be defined" do
            a = FactoryBot.build(:profile)  
            expect(a).to respond_to(:has_conversation_with)
        end
        it "should return false if there is no messages between two users" do
            p1 = FactoryBot.create(:profile) 
            a2 = FactoryBot.create(:account, :id => 2, :email => "ptnguyen@colgate.edu", :password => "colgate13")
            p2 = FactoryBot.create(:profile, :account => a2, :first_name => "Amber", :last_name => "Nguyen")
            c = FactoryBot.create(:conversation, :sender => p1, :receiver => p2)
            expect(p1.has_conversation_with(p2)).to eq(false)
        end
    end
end
