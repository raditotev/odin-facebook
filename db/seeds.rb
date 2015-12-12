# Reset DB

User.destroy_all

# Create Users

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

User.create!(name: "Radi",
                    email: "radi@mail.com",
                    password: "password",
                    password_confirmation: "password")

# Create Posts

users = User.take(10)
user = User.find_by(name: "Radi")
users << user

10.times do
  content = Faker::Lorem.sentence(5)
  users.each {|u| u.posts.create!(content: content)}
end


# Create Friendships


users = User.take(7)

users.each {|friend| user.friends << friend}


