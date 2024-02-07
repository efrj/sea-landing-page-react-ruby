require 'json'

def remove_duplicates_and_empty_keys(file_path)
  unless File.exist?(file_path)
    puts "The file '#{file_path}' was not found."
    return
  end

  users = JSON.parse(File.read(file_path))

  unique_users = users.reject { |user| user['name'].to_s.empty? || user['email'].to_s.empty? }
                      .uniq { |user| [user['name'], user['email']] }

  File.write(file_path, JSON.pretty_generate(unique_users))

  puts 'Duplicate users and records with empty keys removed successfully.'
end

file_path = 'users.json'

remove_duplicates_and_empty_keys(file_path)