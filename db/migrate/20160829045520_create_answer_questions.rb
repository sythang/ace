class CreateAnswerQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_questions do |t|
    	t.belongs_to :answer
    	t.belongs_to :question
    	t.belongs_to :option
      t.timestamps
    end
  end
end
