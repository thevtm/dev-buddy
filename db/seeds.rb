require 'faker'

photo_url_array = [
  "https://avatars0.githubusercontent.com/u/12168698?v=4",
  "https://avatars1.githubusercontent.com/u/36988303?v=4",
  "https://avatars2.githubusercontent.com/u/29202119?v=4",
  "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/s2qpazzl5jm5xrngln1j.jpg",
  "https://avatars1.githubusercontent.com/u/20646607?v=4",
  "https://avatars1.githubusercontent.com/u/38414138?v=4",
  "https://avatars3.githubusercontent.com/u/37291361?v=4",
  "https://avatars2.githubusercontent.com/u/38267204?v=4",
  "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/msmtmeifg0x1knic8qrv.jpg",
  "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/oevq0muhshxykwqhq466.jpg",
  "https://avatars2.githubusercontent.com/u/10833329?v=4",
  "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/tns0dv1jdzeffoqjbq4v.jpg",
  "https://avatars1.githubusercontent.com/u/37129269?v=4",
  "https://avatars2.githubusercontent.com/u/978715?v=4",
  "https://avatars2.githubusercontent.com/u/10217979?v=4"
]

ChatRoom.destroy_all
Match.destroy_all
User.destroy_all

puts "Starting seed..."
30.times do
  user = User.new(
    email: Faker::Internet.email,
    password: "111111",
    password_confirmation: "111111",
    name: Faker::Name.first_name,
    location: Faker::Address.country
  )
  user.remote_profile_picture_url = photo_url_array.sample
  user.save!
end

puts "Finished creating users..."

10.times do
  user_a = User.order(Arel.sql("RANDOM()")).first

  Match.create!(
    user_a_id: user_a.id,
    user_b_id: User.where.not(id: user_a.id).order(Arel.sql("RANDOM()")).first.id,
    match: Faker::Boolean.boolean,
  )
end

puts "Finished creating matches..."

########
# Test #
########

test_user_a = User.new(
  email: "a@a.a",
  password: "111111",
  password_confirmation: "111111",
  name: "Test A",
  location: "Jakarta",
)
test_user_a.remote_profile_picture_url = photo_url_array.sample
test_user_a.save!

test_user_b = User.new(
  email: "b@b.b",
  password: "111111",
  password_confirmation: "111111",
  name: "Test B",
  location: "Tokyo",
  )
test_user_b.remote_profile_picture_url = photo_url_array.sample
test_user_b.save!

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
