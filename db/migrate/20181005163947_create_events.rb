class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :image
      t.text :intro
      t.text :content
      t.datetime :application_deadline
      t.datetime :event_date

      t.timestamps
    end
  end
end
