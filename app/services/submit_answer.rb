class SubmitAnswer
	def initialize(user, params)
		@params = params
		@user = user
	end
	attr_reader :user, :params, :error
	def submit
		ActiveRecord::Base.transaction do
			create_answer
			add_answer_questions
		end
		# p params["test_id"]
		true
	rescue Exception => e
		@error = e.message
		false
	end

	private
	def create_answer
		@answer = user.answers.find_or_initialize_by(test_id: params["test_id"])
		@answer.save if @answer.new_record?
	end

	def add_answer_questions
		answers_questions_params = params["answers"]
		answers_questions_params.each do |hash|
			answer_question = @answer.answer_questions.find_or_initialize_by(question_id: hash["question_id"])
			answer_question.option_id = hash["option_id"]
			answer_question.save!
		end
	end
end