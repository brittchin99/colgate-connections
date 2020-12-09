require 'rails_helper'

RSpec.describe Setting, type: :model do
    context "init method" do
        it "should be defined" do
            a = FactoryBot.build(:setting)  
            expect(a).to respond_to(:init)
        end
        
    end
    context "to_list method" do
        it "should be defined" do
            expect(Setting).to respond_to(:to_list)
        end
    end
    
    
   
end
