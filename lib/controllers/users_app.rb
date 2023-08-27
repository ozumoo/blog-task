require 'json'
require_relative '../models/user'

class UsersApp
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    case request.path
    when '/users'
      handle_create(request, response)
    else
      response.status = 404
      response.write('Not Found')
    end
    response.finish
  end

  private

  def handle_create(request, response)
    params = JSON.parse(request.body.read)
    user = User.new(email: params['email'])

    if user.save
      response.status = 200
      response['Content-Type'] = 'application/json'
      response.write(user.to_json)
    else
      response.status = 422
      response['Content-Type'] = 'application/json'
      response.write({ errors: user.errors.full_messages }.to_json)
    end
  end
end
