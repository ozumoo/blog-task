require 'bundler'
Bundler.require

# Load your application's code
require_relative '../lib/controllers/users_app'
require_relative '../lib/controllers/posts_app'
require_relative '../lib/controllers/ratings_app'
require_relative '../lib/controllers/feedbacks_app'
require_relative '../config/database'  # Or wherever your database setup is
require_relative '../lib/workers/feedback_export_worker'
require_relative '../lib/models/user'      
require_relative '../lib/models/post'      
require_relative '../lib/models/feedback'

# Set up any necessary configurations
# For example, configuring database connection, environment variables, etc.

# You might also want to configure Sidekiq if needed
