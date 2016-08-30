class AnswerQuestion < ApplicationRecord
	belongs_to :question
	belongs_to :answer
	belongs_to :option
	
	# validate :validate_option

	def validate_option
		return true if question.options.exists?(option.id)

		errors.add(:base, "Option is invalid")
	end
end
