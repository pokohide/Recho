class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :username, :string, null: false, default: ''
    add_column :users, :display_name, :string
    add_column :users, :image, :string
  end
end
