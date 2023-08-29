require 'active_record'
require_relative '../../lib/models/post'
require_relative '../../lib/models/user'
require_relative '../../lib/controllers/ratings_app'

# Initialize ActiveRecord and establish database connection
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

RSpec.describe RatingsApp, type: :controller do
  before(:all) do
    # Create database tables (assuming you have migration files)
    ActiveRecord::Schema.verbose = false
    load 'db/schema.rb'
  end

  describe '#create' do
    it 'creates a new rating and updates average rating' do
      ratings_app = RatingsApp.new
      post = Post.create(title: 'Test Post', content: 'Content', author_ip: '127.0.0.1')
      post.user = User.create(email: 'author@example.com')
      post.save

      result = ratings_app.create(post.id, 4)
      expect(result).to be(true) \
    end
  end
end
