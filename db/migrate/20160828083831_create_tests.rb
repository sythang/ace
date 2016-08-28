class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
    	t.string :name
    	t.text :description
    	t.integer :teacher_id
      t.timestamps
    end
  end
end
