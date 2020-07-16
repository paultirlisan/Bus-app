require 'rails_helper'
require 'utilities'

describe "Manage station page" do
	let!(:user) { FactoryGirl.create(:user) }
	let!(:company) { user.build_company(description: "Nice", phone: "0740123456",
								headquarters: "Bucuresti", careers_advertisement: "None") }
	let!(:station) { company.stations.build(name: "Bus Station", city: "Bistrita") }

	subject { station }

	before do
		company.save
		station.save
		sign_in user
		visit new_station_path
		click_button "Create a new station"
	end

	describe "create" do
		before do
			fill_in "Name", with: "Hahaha"
			select "Nasaud", from: "station_city"
		end

		it "should create" do
			expect { click_button "Create new station" }.to change(Station, :count).by(1)
		end

		describe "update" do
			before do
				visit edit_station_path(station)
				fill_in "Name", with: "Updated station"
				click_button "Update"
			end

			it "should have updated correctly" do
				station.name.should eq "Updated station"
			end
		end
	end
end
