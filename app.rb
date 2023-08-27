require 'rack'
require 'rack/session/cookie'
require 'sidekiq/web'
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
