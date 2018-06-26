require 'test_helper'

class ChatRoomMessageTest < ActiveSupport::TestCase
  # setup do
  #   @chat_room = ChatRoom.create!

  #   @user_a = User.create!(
  #     email: "test-a@a.a",
  #     password: "111111",
  #     password_confirmation: "111111",
  #     name: "Test A",
  #     location: "Jakarta",
  #     profile_picture: "photo_a",
  #   )

  #   ChatRoomUser.create!(
  #     chat_room: @chat_room,
  #     user: @user_a,
  #   )

  #   @user_b = User.create!(
  #     email: "test-b@b.b",
  #     password: "111111",
  #     password_confirmation: "111111",
  #     name: "Test B",
  #     location: "Tokyo",
  #     profile_picture: "photo_b",
  #   )

  #   ChatRoomUser.create!(
  #     chat_room: @chat_room,
  #     user: @user_b,
  #   )
  # end

  # test "user is a member of the chat room" do
  #   assert_nothing_raised do
  #     ChatRoomMessage.create!(
  #       chat_room: @chat_room,
  #       user: @user_a,
  #       message: "Hi! This test should pass!",
  #     )
  #   end
  # end

  # test "user is not a member of the chat room" do
  #   user_c = User.create!(
  #     email: "test-c@b.b",
  #     password: "111111",
  #     password_confirmation: "111111",
  #     name: "Test C",
  #     location: "Tokyo",
  #     profile_picture: "photo_c",
  #   )

  #   assert_raises do
  #     ChatRoomMessage.create!(
  #       chat_room: @chat_room,
  #       user: user_c,
  #       message: "Hi! This test should fail!",
  #     )
  #   end
  # end
end
