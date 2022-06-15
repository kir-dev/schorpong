class AddDeletedAtToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :deleted_at, :datetime
    add_index :items, :deleted_at
  end
end
