class AddApiTokenToUser < ActiveRecord::Migration[5.0]
  def change
  	change_table(:users) do |t|
  		t.string :api_token, null: true
  	end
  	add_index :users, :api_token
  end
end
