# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Generate 10 Teacher
User.destroy_all
Test.destroy_all
(1..20).each do |i|
	User.create(name: "Teacher #{i}", email: "teacher#{i}@ace.com", password: '12345678', role: 'teacher')
end

(1..20).each do |i|
	User.create(name: "Student #{i}", email: "student#{i}@ace.com", password: '12345678', role: 'student')
end

teacher = User.create!(name: "Teacher", email: "teacher@ace.com", password: '123123123', role: 'teacher')
test  = teacher.tests.create!(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph)
question  = test.questions.create!(label: Faker::Lorem.sentence, description: Faker::Lorem.paragraph)
question.options.create!(content: Faker::Lorem.sentence, is_correct_answer: true)