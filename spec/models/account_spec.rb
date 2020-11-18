require 'rails_helper'

RSpec.describe Account, type: :model do
  
  context "the connected_to method" do
        it "should be defined" do
          a = FactoryBot.build(:account)
          expect(a).to respond_to(:connected_to)
        end
        it "should return true if two accounts are connected" do
        a = FactoryBot.build(:account)
        f = FactoryBot.build(:account, :email => "ptnguyen@colgate.edu")
        c = FactoryBot.build(:connection, :account => a, :friend => f)
        expect(a).to receive(:connections).and_return([c])
        expect(a.connected_to(f)).to eq(true)
      end
      
      it "should return false if two accounts are not connected" do
        a = FactoryBot.build(:account)
        f = FactoryBot.build(:account, :email => "ptnguyen@colgate.edu")
        c = FactoryBot.build(:connection, :account => a, :friend => f)
        expect(a).to receive(:connections).and_return([])
        expect(a.connected_to(f)).to eq(false)
      end
  end
end
