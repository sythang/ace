class Option < ApplicationRecord
	belongs_to :question, inverse_of: :options
	has_many :answer_questions
end
