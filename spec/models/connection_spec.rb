require 'rails_helper'

RSpec.describe Connection, type: :model do
    context "the create method" do
        it "should be defined" do
            expect(Connection).to respond_to(:create)
        end
        it "should show the correct friendship" do
            a = FactoryBot.build(:account)
            f = FactoryBot.build(:account, :email => "ptnguyen@colgate.edu")
            c = FactoryBot.build(:connection, :account => a, :friend => f)
            expect(c.account).to eq(a)
            expect(c.friend).to eq(f)
      end
      
  end
end
