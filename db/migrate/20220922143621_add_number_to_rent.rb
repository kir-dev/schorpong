class AddNumberToRent < ActiveRecord::Migration[7.0]
  def change
    add_column :rents, :number, :integer
  end
end
