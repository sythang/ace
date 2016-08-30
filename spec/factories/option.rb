FactoryGirl.define do
	factory :option do |f|
		f.content { Faker::Lorem.sentences }
		f.is_correct_answer false
	end
end