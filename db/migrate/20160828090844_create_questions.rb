class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :label
      t.text :description
      t.string :correct_answer
      t.belongs_to :test
      t.timestamps
    end
  end
end
