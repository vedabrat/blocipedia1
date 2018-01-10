class AddRoleToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string
    add_column :users, :premium, :boolean, default: false
    add_column :users, :standard, :boolean, default: true

  end
end
