require "rails_helper"
require 'spec_helper'


RSpec.feature "Profile", :type => :feature do
    before :each do
        populate_data
        admin = Account.create!(:email => 'admin@colgate.edu', :admin => true, :password => "colgate13")
        admin.profile.update!(:first_name => "Admin", :last_name => "Colgate",
            :pronouns => "they/them/theirs", :class_year => 2021, :majors => "Computer Science", :minors => "English", :interests => "Dance", :status => "No status to share")
        sign_in(admin)            
    end
    context "index page" do
        it "should show the profiles in name order by default" do
            visit "/profiles"
            first_names = []
            page.all(".profilefirst_name").each { |x| first_names << x.text }
            expect(first_names).to match_array(first_names.sort)
        end
    end
    context "update page" do
        it "should successfully update last name" do
            visit edit_profile_path(5)
            fill_in 'Last name', with: 'Coolgate'
            click_button "Update Profile"
            expect(page).to have_text("Admin Coolgate")
        end
        it "should fail to update last name" do
            visit edit_profile_path(5)
            fill_in 'Last name', with: ''
            click_button "Update Profile"
            expect(page).to have_text("Last name can't be blank")
        end
    end
    
    def sign_in(account)
        visit new_account_session_path
        fill_in 'Email', with: account.email
        fill_in 'Password', with: account.password
        click_button 'Log in'
    end
    def populate_data
        amber = Account.create!(:email => 'ptnguyen@colgate.edu', :admin => false, :password => "colgate13")
        amber.profile.update!(:first_name => "Amber", :last_name => "Nguyen",
            :pronouns => "she/her/hers", :class_year => 2021, :majors => ["Computer Science", "Economics"], :minors => "Japanese", :interests => "Anime")
        
        emily = Account.create!(:email => 'ecruzgonzalez@colgate.edu', :admin => false, :password => "colgate13")
        emily.profile.update!(:first_name => "Emily", :last_name => "Cruz Gonzalez",
            :pronouns => "she/her/hers", :class_year => 2021, :majors => ["Computer Science", "English"], :minors => "Anthropology", :interests => "Anime")
        
        britt = Account.create!(:email => 'bchin@colgate.edu', :admin => false, :password => "colgate13")
        britt.profile.update!(:first_name => "Brittney", :last_name => "Chin",
            :pronouns => "she/her/hers", :class_year => 2021, :majors => "Computer Science", :minors => ["LGBTQ Studies", "Educational Studies"], :interests => "Performing Arts")
        
        si = Account.create!(:email => 'swei@colgate.edu', :admin => false, :password => "colgate13")
        si.profile.update!(:first_name => "Si", :last_name => "Wei",
            :pronouns => "she/her/hers", :class_year => 2021, :majors => ["Computer Science", "International Relations"], :interests => "Sports and Athletics")
    end
end