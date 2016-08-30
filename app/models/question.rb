class Question < ApplicationRecord
	belongs_to :test, inverse_of: :questions
	has_many :options, inverse_of: :question
	accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true
end
