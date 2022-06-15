class CreateRents < ActiveRecord::Migration[7.0]
  def change
    create_table :rents do |t|
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :begin
      t.datetime :end
      t.integer :state

      t.timestamps
    end
  end
end
