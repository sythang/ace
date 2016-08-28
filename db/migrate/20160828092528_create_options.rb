class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :content
      t.boolean :is_correct_answer

      t.timestamps
    end
  end
end
