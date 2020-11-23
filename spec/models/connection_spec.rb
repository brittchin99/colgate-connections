require 'rails_helper'

RSpec.describe Connection, type: :model do
    context "create method" do
        it "should be defined" do
            expect(Connection).to respond_to(:create)
        end
        it "should show the correct friendship" do
            p1 = FactoryBot.create(:profile)
            a2 = FactoryBot.create(:account, :id => 2, :email => "ptnguyen@colgate.edu", :password => "colgate13")
            p2 = FactoryBot.create(:profile, :account => a2, :first_name => "Amber", :last_name => "Nguyen")
            c = FactoryBot.create(:connection, :profile => p1, :friend => p2)
            expect(c.profile).to eq(p1)
            expect(c.friend).to eq(p2)
        end
    end
end
