class Answer < ApplicationRecord
	belongs_to :user
	belongs_to :test
	has_many :answer_questions, dependent: :destroy
end
