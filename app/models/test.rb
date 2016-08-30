class Test < ApplicationRecord
	has_many :questions, inverse_of: :test, dependent: :destroy
	has_many :answers, dependent: :destroy
	accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
	belongs_to :teacher, foreign_key: 'teacher_id', class_name: 'User'
end
