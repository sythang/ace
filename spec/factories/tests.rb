FactoryGirl.define do
	factory :test do
		name { Faker::Lorem.sentence }
		description { Faker::Lorem.paragraph }
		teacher_id 1
	end
end