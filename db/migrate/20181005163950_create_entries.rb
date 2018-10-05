class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.text :comment
      t.references :team, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
