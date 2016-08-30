FactoryGirl.define do
	factory :question do |f|
		f.label { Faker::Lorem.sentence }
		f.description { Faker::Lorem.paragraph }
	  f.test_id 1
	end
end