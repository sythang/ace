class AddQuestionIdToTest < ActiveRecord::Migration[5.0]
  def change
  	change_table(:options) do |t|
  		t.belongs_to :question
  	end
  end
end
