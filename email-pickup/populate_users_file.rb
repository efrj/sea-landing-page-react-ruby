require 'json'
require 'faker'

def generate_random_users(count)
  users = []
  count.times do |i|
    name = Faker::Name.name
    email = Faker::Internet.email(name: name, separators: '.')
    users << { 'name' => name, 'email' => email }
  end
  users
end

def populate_users_file(file_path, num_records)
  users = generate_random_users(num_records)

  if File.exist?(file_path)
    existing_users = JSON.parse(File.read(file_path))
    users += existing_users
  end

  File.write(file_path, JSON.pretty_generate(users))
end

file_path = 'users.json'

num_records = 100

populate_users_file(file_path, num_records)

puts "The 'users.json' file was populated with #{num_records} records."