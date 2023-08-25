require 'webrick'

require_relative 'lib/controllers/users_controller'
require_relative 'lib/controllers/posts_controller'
require_relative 'lib/controllers/ratings_controller'
require_relative 'lib/controllers/feedbacks_controller'
require_relative 'config/database'
require_relative 'lib/workers/feedback_export_worker'


server = WEBrick::HTTPServer.new(Port: 3000)

# Users Routes
server.mount '/users' , UsersController


# Posts Routes
server.mount '/posts' , PostsController
server.mount '/posts/top_rated', PostsController, :top_rated
server.mount '/posts/author_ips', PostsController, :author_ips

server.mount '/ratings' , RatingsController
server.mount '/feedbacks' , FeedbacksController


trap('INT') { server.shutdown }


# keep main thread alive
loop {}