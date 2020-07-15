require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
	subject { page }

	describe "sign up with invalid information" do
		before { visit new_user_registration_path }

		describe "as normal user" do
			before do
				fill_in "Name", with: "Paul"
				fill_in "Email", with: "paul@example.com"
				fill_in "Password", with: "password"
				fill_in "Password", with: "passwordd"
				click_button "Sign up"
			end

			it { should have_content("error") }
		end

		describe "as company user" do
			before do
				fill_in "Name", with: "Paul"
				fill_in "Email", with: "paul@example.com"
				fill_in "Password", with: "password"
				fill_in "Password confirmation", with: "password"
				check "active"
				fill_in "Phone", with: "1" * 16
				fill_in "Headquarters", with: "Here"
				fill_in "Description", with: "What an awesome company!"
				fill_in "Careers advertisement", with: "No announcements. Stay tuned!"
				click_button "Sign up"
			end

			it { should have_content("error") }
		end
	end

	describe "sign up normal user" do
		before do
			visit new_user_registration_path
			fill_in "Name", with: "Ionica"
			fill_in "Email", with: "ionica@example.com"
			fill_in "Password", with: "password"
			fill_in "Password confirmation", with: "password"
			click_button "Sign up"
		end

		it { should have_content "My profile" }
		it { should_not have_content "Settings" }

		describe "update profile" do
			before { visit edit_user_registration_path }

			describe "with invalid information" do
				before do
					fill_in "Name", with: "IONICA"
					fill_in "Current password", with: "passwordd"
					click_button "Update"
				end

				it { should have_content "error" }
			end

			describe "with valid information" do
				let(:user) { User.find_by_email("ionica@yahoo.com") }
				before do
					fill_in "Name", with: "IONICA"
					fill_in "Email", with: "ionica@yahoo.com"
					fill_in "Current password", with: "password"
					click_button "Update"
				end

				it { should_not have_content "error" }
				it "update done properly" do
					user.name.should eq "IONICA"
				end
			end
		end
	end

	describe "sign up company user" do
		before do
			visit new_user_registration_path
			fill_in "Name", with: "Saveta"
			fill_in "Email", with: "saveta@example.com"
			fill_in "Password", with: "password"
			fill_in "Password confirmation", with: "password"
			check "active"
			fill_in "Phone", with: "0740123456"
			fill_in "Headquarters", with: "Bucuresti"
			fill_in "Description", with: "A very nice company."
			fill_in "Careers advertisement", with: "No advertisement. Stay tuned!"
			click_button "Sign up"
		end

		it { should have_content "Settings" }
		it { should_not have_content "My profile" }

		describe "update details" do
			before { visit edit_user_registration_path }

			describe "with invalid information" do
				before do
					fill_in "Name", with: "SAVETA"
					fill_in "Current password", with: "passwordd"
					click_button "Update"
				end

				it { should have_content "error" }
			end

			describe "with valid information" do
				let(:user) { User.find_by_email("saveta@yahoo.com") }
				before do
					fill_in "Name", with: "SAVETA"
					fill_in "Email", with: "saveta@yahoo.com"
					fill_in "Current password", with: "password"
					fill_in "Description", with: "Test the company Settings page."
					click_button "Update"
				end

				it { should_not have_content "error" }
				it "update done properly" do
					user.name.should eq "SAVETA"
					user.company.description.should eq "Test the company Settings page."
				end
			end
		end
	end

end
