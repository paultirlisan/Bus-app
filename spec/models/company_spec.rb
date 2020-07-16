require 'rails_helper'

RSpec.describe Company, type: :model do
	let(:user) { FactoryGirl.create(:user) }
	let(:company) { user.build_company(description: "Nice", phone: "0740123456",
								headquarters: "Bucuresti", careers_advertisement: "None") }

	subject { company }

	describe "should respond to its fields" do
		it { should respond_to(:user_id) }
		it { should respond_to(:description) }
		it { should respond_to(:phone) }
		it { should respond_to(:headquarters) }
		it { should respond_to(:careers_advertisement) }
		it { should respond_to(:active) }
		it { should respond_to(:user) }
		it { should respond_to(:stations) }

		it { should be_valid(company) }
		it { should be_valid(company.active) }
	end

	describe "should have the correct user" do
		before { company.save }

		it { should equal user.company }
	end

	describe "should have a valid description" do
		before { company.description = " " }

		it { should_not be_valid(company) }
	end

	describe "should have a valid phone" do
		before { company.phone = "074o123456" }

		it { should_not be_valid(company) }
	end
	
	describe "should have valid headquarters" do
		before { company.headquarters = " " }

		it { should_not be_valid(company) }
	end

	describe "should have a careers advertisement" do
		before { company.careers_advertisement = " " }

		it { should_not be_valid(company) }
	end

	describe "should have stations" do
		before { company.save }
		let!(:first_station) { company.stations.create(name: "Bus Station", city: "Bistrita") }
		let!(:second_station) { company.stations.create(name: "Piata Unirii", city: "Bucuresti") }

		it "in correct order" do
			company.stations.should eq [first_station, second_station]
		end
	end

	describe "should be destroyed when the user is destroyed" do
		before { company.save }

		it "should delete" do
			expect { user.destroy }.to change(Company, :count).by(-1)
		end
	end
end
