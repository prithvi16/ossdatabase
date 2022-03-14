puts "================================"
puts "Creating admin@example.com"
AdminUser.create!(email: "admin@example.com", password: "222222", password_confirmation: "222222") if Rails.env.development?
puts "============done================"

puts "================================"
puts "Creating Projects, fulflling promises, vocal for local"
1000.times do
  project = Project.create!(name: Faker::App.name,
    description: Faker::Markdown.sandwich(sentences: 5),
    website: Faker::Internet.url,
    tag_line: Faker::Company.catch_phrase,
    first_release: (1000..5000).to_a.sample.days.ago,
    last_release: (500..1000).to_a.sample.days.ago,
    premium: [true, false].sample)
  puts "Created project" + project.name
end
puts "============done================"

# puts "================================"
# puts "Creating users, feel like god"
# 100.times do
#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name
#   username = SecureRandom.hex(10)
#   email = username + "@example.com"
#   User.create!(
#     first_name: first_name,
#     last_name: last_name,
#     email: email,
#     username: username,
#     password: "222222",
#     confirmed_at: DateTime.now
#   )
#   puts "Created user" + username
# end
# puts "============done================"

puts "================================"
puts "Creating tags"
70.times do
  Tag.create!(name: Faker::Color.unique.color_name, tag_type: TOP_TAG_TYPES.sample)
end
puts "================================"
puts "Attaching projects to tags"
Project.all.each do |project|
  TOP_TAG_TYPES.each do |tag_type|
    tag = Tag.where(tag_type: tag_type).order("RANDOM()").limit(1)
    project.tags << tag
    puts "Attached project #{project.name} to #{tag.name}"
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
puts "Created sam@example.com, he is admin with password 222222"
User.create!(
  first_name: "tan",
  last_name: "example",
  email: "tan@example.com",
  username: "tan",
  admin: false,
  password: "222222",
  confirmed_at: DateTime.now
)
puts "Created tan@example.com, he is non-admin with password 222222"
puts "==============done=============="
puts "Creating static pages"
StaticPage.create!(key: "about", description: "TEST", title: "About", content: File.read(File.open("#{Rails.root}/db/example_markdown/about.md")))
StaticPage.create!(key: "site-updates", description: "TEST", title: "Site Updates", content: File.read(File.open("#{Rails.root}/db/example_markdown/site-updates.md")))
StaticPage.create!(key: "contact", description: "TEST", title: "Contact", content: File.read(File.open("#{Rails.root}/db/example_markdown/contact.md")))
puts "===========DONE==============="
