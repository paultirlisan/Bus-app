FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person #{n}" }
		sequence(:email) { |n| "person#{n}@example.com" }
		password "password"
		password_confirmation "password"
	end

=begin
	factory :company do
		user_id FactoryGirl.create(:user).id
		description "Nice"
		phone "0740123456"
		headquarters "Bucuresti"
		careers_advertisement "None."
	end
=end
end