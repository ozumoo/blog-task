require 'rack'
require 'rack/session/cookie'
require 'sidekiq/web'
require 'webrick'
require 'rack/contrib/jsonp' 
require 'active_record'
require_relative 'lib/controllers/users_app'
require_relative 'lib/controllers/posts_app'
require_relative 'lib/controllers/ratings_app'
require_relative 'lib/controllers/feedbacks_app'
require_relative 'config/database'
require_relative 'lib/workers/feedback_export_worker'

class App
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

   

    # Define your routing logic here
    case request.path
    when '/users'
      UsersApp.new.call(env)
    when '/posts', '/posts/top_rated', '/posts/author_ips'
      PostsApp.new.call(env)
    when '/ratings'
      RatingsApp.new.call(env)
    when '/feedbacks'
      FeedbacksApp.new.call(env)
    when '/sidekiq'
      env['PATH_INFO'] = '/sidekiq'
      Sidekiq::Web.new.call(env)
    else
      response.status = 404
      response.write('Not Found')
    end

    response.finish
  end
end

# Use Rack::Session::Cookie for Sidekiq
use Rack::Session::Cookie, secret: '7e6bf1f781fdf3ba1fc21cc8c59e2dcbc24d490bcb1b27b4e35e1fccf4bcbe9aa8c48a2b90ef7634c6f01e67fc7914cd220ebd19030706e57b44ae36b8a17db8', path: '/sidekiq'
use Rack::JSONP # Add this line


app = Rack::Builder.new do
    # ...
  
    map '/sidekiq' do
      use Rack::Deflater
      run Sidekiq::Web
    end
end

run app

# Start the Rack server
run App.new
