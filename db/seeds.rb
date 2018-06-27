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
  "https://avatars2.githubusercontent.com/u/10217979?v=4",
  "https://avatars0.githubusercontent.com/u/31037203?s=400&v=4",
  "https://avatars0.githubusercontent.com/u/29884402?s=400&v=4",
  "https://avatars1.githubusercontent.com/u/9403101?s=400&v=4",
  "https://avatars1.githubusercontent.com/u/7533706?s=400&v=4",
  "https://avatars1.githubusercontent.com/u/50518?s=400&v=4",
  "https://avatars0.githubusercontent.com/u/2265232?s=400&v=4",
  "https://avatars0.githubusercontent.com/u/12513436?s=400&v=4",
  "https://avatars1.githubusercontent.com/u/22532?s=400&v=4",
  "https://avatars1.githubusercontent.com/u/18394029?s=400&v=4",
  "https://avatars0.githubusercontent.com/u/7393354?s=400&v=4",
  "https://ca.slack-edge.com/T02NE0241-U8TUMGRC7-b79426e0803a-512",
]

ChatRoom.destroy_all
User.destroy_all

puts "Starting seed..."
photo_url_array.map do |photo_url|
  user = User.new(
    email: Faker::Internet.email,
    password: "111111",
    password_confirmation: "111111",
    name: Faker::Name.name,
    location: Faker::Address.country
  )
  user.remote_profile_picture_url = photo_url
  user.save!
end

########
# Test #
########

test_user_a = User.new(
  email: "a@a.a",
  password: "111111",
  password_confirmation: "111111",
  name: "Donald",
  location: "Washington DC",
)
test_user_a.remote_profile_picture_url = "https://www.skyparksecure.com/blog/wp-content/uploads/2017/04/donald-trump-bankruptcy-lies-r.jpg"
test_user_a.save!

test_user_b = User.new(
  email: "b@b.b",
  password: "111111",
  password_confirmation: "111111",
  name: "Hillary",
  location: "Trump Tower",
  )
test_user_b.remote_profile_picture_url = "http://freebeacon.com/wp-content/uploads/2017/12/Clinton-540x360.jpg"
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
  message: "Hi, how are you?!",
)

ChatRoomMessage.create!(
  chat_room: test_chat_room,
  user: test_user_b,
  message: "I finished the assignment!",
)
