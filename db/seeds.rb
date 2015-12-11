# Reset DB

User.destroy_all
Post.destroy_all

#Users

50.times do
  name = Faker::Name.name
  name_email = name.downcase.split
  name_email = name_email.join("_")
  email = "#{name_email}@mail.com"
  password = "password12"
  User.create!(name: name,
                      email: email,
                      password: password,
                      password_confirmation: password)
end

# Posts

users = User.take(10)

10.times do
  content = Faker::Lorem.sentence(5)
  users.each {|u| u.posts.create!(content: content)}
end


# Friendships

user = User.last
users = User.take(6)

users.each {|friend| user.friends << friend}


