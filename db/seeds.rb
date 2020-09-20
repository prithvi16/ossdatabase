puts "================================"
puts "Creating admin@example.com"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
puts "================================"

puts "================================"
puts "Creating Projects, fulflling promises, vocal for local"
1000.times do
  Project.create!(name: Faker::App.name, 
    description: Faker::Markdown.sandwich(sentences: 5), 
    website: Faker::Internet.url, 
    first_release: (1000..5000).to_a.sample.days.ago,
    last_release: (500..1000).to_a.sample.days.ago,
    premium: [true, false].sample
  )
end
puts "=============done=================="

puts "================================"
puts "Creating users, feel like god"
100.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = SecureRandom.hex(10)
  email = username + "@example.com"
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    username:username,
    password: "222222",
    confirmed_at: DateTime.now
  )
end
puts "=============done=================="

puts "================================"
puts "Creating tags"
70.times do
  Tag.create!(name: Faker::Color.unique.color_name)
end
puts "================================"
puts "Creating projects"
Project.all.each do |project|
  3.times do
    project.tags << Tag.where('id NOT IN (?)', project.tags.ids ).limit(1).order("RANDOM()")
  end
end
puts "================================"
puts "Creating test users"
User.create!(
  first_name: "sam",
  last_name: "example",
  email: "sam@example.com",
  username: "sam",
  admin: true,
  password: "222222",
  confirmed_at: DateTime.now
)
User.create!(
  first_name: "tan",
  last_name: "example",
  email: "tan@example.com",
  username: "tan",
  admin: false,
  password: "222222",
  confirmed_at: DateTime.now
)
