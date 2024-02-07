require 'json'

if File.exist?('users.json')
  File.write('users.json', '[]')

  puts 'All contacts have been removed from the users.json file.'
else
  puts 'The users.json file does not exist.'
end
