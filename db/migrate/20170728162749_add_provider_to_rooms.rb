class AddProviderToRooms < ActiveRecord::Migration[5.0]
  def change
    remove_column :rooms, :slide_type
    add_column :rooms, :provider, :integer
    add_column :rooms, :html, :text
  end
end
