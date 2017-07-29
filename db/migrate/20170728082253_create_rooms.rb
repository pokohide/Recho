class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.references :user, foreign_key: true
      t.string :admin_key, default: '', null: false, unique: true
      t.string :public_key, default: '', null: false, unique: true
      t.string :slug, default: '', null: false, unique: true
      t.string :title, default: '', null: false
      t.integer :provider
      t.string :slide_url, default: '', null: false
      t.text :html

      t.timestamps
    end

    add_index :rooms, [:admin_key, :public_key], unique: true
  end
end
