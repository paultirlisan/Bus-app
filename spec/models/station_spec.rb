require 'rails_helper'
require 'utilities'

RSpec.describe Station, type: :model do
	let(:user) { FactoryGirl.create(:user) }
	let(:company) { user.build_company(description: "Nice", phone: "0740123456",
								headquarters: "Bucuresti", careers_advertisement: "None") }
	let(:station) { company.stations.build(name: "Bus Station", city: "Bistrita") }

	subject { station }

	describe "should respond to its fields and methods" do
		it { should respond_to(:name) }
		it { should respond_to(:city) }
		it { should respond_to(:company) }

		it { should be_valid(:station) }
		it "should belong to the correct company" do
			station.company.should eq company
		end
	end

	describe "should be destroyed when the company is destroyed" do
		before do
			company.save
			station.save
		end

		it "should delete" do
			expect { user.destroy }.to change(Station, :count).by(-1)
		end
	end
end
