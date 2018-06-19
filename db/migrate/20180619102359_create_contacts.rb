class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :user_a_id, foreign_key: true, null: false
      t.integer :user_b_id, foreign_key: true, null: false
      t.datetime :last_activity, null: false

      t.timestamps
    end
  end
end
