require "rails_helper"
require 'spec_helper'


RSpec.feature "Account", :type => :feature do
    context "sign up page" do
        it "should successfully sign up" do
            sign_up_with("admin@colgate.edu", "colgate13")
            expect(page).to have_text("Log in")
            expect(page).to have_text("Account successfully created.")
        end
        it "should not sign up with invalid email" do
            sign_up_with("admincolgate", "colgate13")
            expect(page).to have_text("Failed to create account.")
        end
    end
    context "log in page" do
        it "should successfully log in" do
            admin = Account.create!(:email => 'admin@colgate.edu', :admin => true, :password => "colgate13")
            sign_in(admin)
            expect(page).to have_text("Class year")
        end
        it "should redirect to update profile if account is newly created" do
            admin = Account.create!(:email => 'admin@colgate.edu', :admin => true, :password => "colgate13")
            sign_in(admin)
            visit profile_path(1)
            expect(page).to have_text("Edit your profile")
        end
    end
    
    def sign_in(account)
        visit new_account_session_path
        fill_in 'Email', with: account.email
        fill_in 'Password', with: account.password
        click_button 'Log in'
    end
    def sign_up_with(email, password)
      visit new_account_registration_path
      fill_in 'Colgate Email', with: email
      fill_in 'Password', with: password
      click_button 'Create Account'
    end
end