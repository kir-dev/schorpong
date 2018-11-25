class AddShowedUpToEntriesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :showed_up, :boolean, default: false
  end
end
