class CreateChatRoomMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_room_messages do |t|
      t.references :chat_room, foreign_key: true
      t.references :user, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
