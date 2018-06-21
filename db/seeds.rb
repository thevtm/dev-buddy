require 'faker'

ChatRoom.destroy_all
Match.destroy_all
User.destroy_all

30.times do
  User.create!(
    email: Faker::Internet.email,
    password: "111111",
    password_confirmation: "111111",
    name: Faker::Name.name,
    location: Faker::Address.country,
    profile_picture: Faker::Name.name,
  )
end

10.times do
  user_a = User.order(Arel.sql("RANDOM()")).first

  Match.create!(
    user_a_id: user_a.id,
    user_b_id: User.where.not(id: user_a.id).order(Arel.sql("RANDOM()")).first.id,
    match: Faker::Boolean.boolean,
  )
end

########
# Test #
########

test_user_a = User.create!(
  email: "a@a.a",
  password: "111111",
  password_confirmation: "111111",
  name: "Test A",
  location: "Jakarta",
  profile_picture: "photo_a",
)

test_user_b = User.create!(
  email: "b@b.b",
  password: "111111",
  password_confirmation: "111111",
  name: "Test B",
  location: "Tokyo",
  profile_picture: "photo_b",
)

Match.create!(
  user_a_id: test_user_a.id,
  user_b_id: test_user_b.id,
  match: true,
)

Match.create!(
  user_a_id: test_user_b.id,
  user_b_id: test_user_a.id,
  match: true,
)

test_chat_room = ChatRoom.create!()

ChatRoomUser.create!(
  chat_room: test_chat_room,
  user: test_user_a,
)

ChatRoomUser.create!(
  chat_room: test_chat_room,
  user: test_user_b,
)

ChatRoomMessage.create!(
  chat_room: test_chat_room,
  user: test_user_a,
  message: "Hi Test!",
)
