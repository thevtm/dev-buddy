class AddExtraInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :location, :string
    add_column :users, :profile_picture, :string
  end
end
