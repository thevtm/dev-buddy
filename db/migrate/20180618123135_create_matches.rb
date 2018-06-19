class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :user_a_id, foreign_key: true, null: false
      t.integer :user_b_id, foreign_key: true, null: false
      t.boolean :match, null: false

      t.timestamps
    end
  end
end
