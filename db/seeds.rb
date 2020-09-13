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
  username = first_name.downcase + last_name.downcase + SecureRandom.hex(3)
  email = username + "@example.com"
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    username:username,
    password: "222222"
  )
end
puts "=============done=================="

100.times do
  Tag.create!(name: Faker::Color.color_name)
end

Project.all.each do |project|
  3.times do
    project.tags << Tag.limit(1).order("RANDOM()")
  end
end
User.create!(
  first_name: "sam",
  last_name: "example",
  email: "sam@example.com",
  username: "sam",
  password: "222222"
)
