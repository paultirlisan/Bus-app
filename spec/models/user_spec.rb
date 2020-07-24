require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { FactoryGirl.create(:user) }
	subject { user }

	describe "should have name, email, encrypted_password, reset_password, company" do
		it { should respond_to(:name) }
		it { should respond_to(:email) }
		it { should respond_to(:password) }
		it { should respond_to(:password_confirmation) }
		it { should respond_to(:encrypted_password) }
		it { should respond_to(:reset_password_token)}
		it { should respond_to(:reset_password_sent_at) }
		it { should respond_to(:company) }
		it { should respond_to(:journeys) }

		it { should be_valid(user) }
	end

	describe "should have valid name" do
		before { user.name = " " }

		it { should_not be_valid(user) }
	end

	describe "should have a valid email" do
		before { user.email = "invalid@gmailcom" }

		it { should_not be_valid(user) }
	end

	describe "should have a non-blank email" do
		before { user.email = " " }

		it { should_not be_valid(user) }
	end
end
