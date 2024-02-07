require 'json'
require 'webrick'

class NewsletterApp < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    enable_cors(response)
    
    case request.path
    when '/'
      response.body = 'Welcome to the newsletter application!'
    when '/list'
      response.body = list_users
    else
      response.body = 'Route not found.'
    end

    response.content_type = 'text/plain'
  end

  def do_POST(request, response)
    enable_cors(response)
    
    case request.path
    when '/register'
      register_user(request)
      response.body = 'User registered successfully!'
    else
      response.body = 'Route not found.'
    end

    response.content_type = 'text/plain'
  end

  private

  def enable_cors(response)
    response['Access-Control-Allow-Origin'] = '*'
    response['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
    response['Access-Control-Allow-Headers'] = 'Content-Type'
    response['Access-Control-Allow-Credentials'] = 'true'
  end

  def register_user(request)
    data = get_request_data(request)

    return 'Invalid request data' if data.nil?

    users = File.exist?('users.json') ? JSON.parse(File.read('users.json')) : []

    users << { 'name' => data['name'], 'email' => data['email'] }

    File.write('users.json', JSON.pretty_generate(users))
  end

  def get_request_data(request)
    begin
      return JSON.parse(request.body)
    rescue JSON::ParserError
      return request.query
    end
  end

  def list_users
    if File.exist?('users.json')
      users = JSON.parse(File.read('users.json'))
      users.to_json
    else
      'No users registered yet.'
    end
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount('/', NewsletterApp)

trap('INT') { server.shutdown }

server.start