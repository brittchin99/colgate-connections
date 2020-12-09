require "rails_helper"
require 'spec_helper'


RSpec.feature "Connection", :type => :feature do
    before :each do
        populate_data
    end
    context "index page" do
        it "should show the connections in name order by default" do
            visit "/connections"
            first_names = []
            page.all(".profilefirst_name").each { |x| first_names << x.text }
            expect(first_names).to match_array(first_names.sort)
        end
        # it "should show the connections filtered by search term" do
        #     visit "/connections"
        #     # find('.search', :text => 'Search').fill_in '2021'
        #     fill_in 'connection_search', with: '2021'
        #     click_button 'Search'
            
        #     expect(page.all(".profile").length ).to eq(2)
        # end
    end
    context "disconnect" do
        it "should successfully disconnect with a connection" do
            visit profile_path(1)
            find('.dropdown-menu', :text => 'Disconnect').click
            click_on 'Disconnect'
            expect(page).to have_text("Send Friend Request")
        end
    end
    context "add connection" do
        it "should successfully create connection" do
            visit profile_path(3)
            find('.btn-primary', :text => 'Accept').click
            expect(page).to have_text("Message")
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
        admin = Account.create!(:email => 'admin@colgate.edu', :admin => true, :password => "colgate13")
        admin.profile.update!(:first_name => "Admin", :last_name => "Colgate",
            :pronouns => "they/them/theirs", :class_year => 2021, :majors => "Computer Science", :minors => "English", :interests => "Dance", :status => "No status to share")
        admin.profile.connections.create!(:profile => admin.profile, :friend => amber.profile)
        amber.profile.connections.create!(:profile => amber.profile, :friend => admin.profile)
        admin.profile.connections.create!(:profile => admin.profile, :friend => si.profile)
        si.profile.connections.create!(:profile => si.profile, :friend => admin.profile)
        admin.profile.friend_requests.create!(:profile => admin.profile, :friend => britt.profile)
        sign_in(admin) 
    end
end