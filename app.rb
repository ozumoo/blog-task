require 'webrick'

require_relative 'lib/controllers/users_controller'
require_relative 'lib/controllers/posts_controller'
require_relative 'lib/controllers/ratings_controller'
require_relative 'lib/controllers/feedbacks_controller'
require_relative 'config/database'
require_relative 'lib/workers/feedback_export_worker'


server = WEBrick::HTTPServer.new(Port: 3000)

# Map routes to controllers
server.mount '/users' , UsersController
server.mount '/posts' , PostsController
server.mount '/ratings' , RatingsController
server.mount '/feedbacks' , FeedbacksController


trap('INT') { server.shutdown }


# keep main thread alive
loop {}