class AddIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :mail, unique: true
  end
end
