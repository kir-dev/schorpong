class AddAnimationEnabledToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :animation_enabled, :boolean
  end
end
