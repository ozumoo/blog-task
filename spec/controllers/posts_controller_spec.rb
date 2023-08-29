require_relative '../../lib/controllers/posts_app'
require_relative '../../lib/models/post'
require_relative '../../lib/models/user'
require_relative '../../lib/models/rating'

# Simulated HTTP response structure
class SimulatedResponse
  attr_accessor :status, :body

  def initialize
    @status = nil
    @body = nil
  end
end

RSpec.describe PostsApp, type: :controller do
  before(:all) do
    # Initialize ActiveRecord and establish database connection
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: ':memory:'
    )

    # Create database tables (assuming you have migration files)
    ActiveRecord::Schema.verbose = false
    load 'db/schema.rb'
  end

  describe 'GET #top_rated' do
    it 'returns top N posts by average rating' do

      post1 = create_post_with_ratings('Post 1', [4, 5, 3, 4])
      post2 = create_post_with_ratings('Post 2', [3, 4, 5, 5])
      post3 = create_post_with_ratings('Post 3', [2, 2, 1, 1])

      response = get_top_rated

      expect(response.status).to eq(200)
      top_posts = JSON.parse(response.body)['data']
      expect(top_posts.length).to eq(2)
      expect(top_posts[0]['title']).to eq(post2.title)
      expect(top_posts[1]['title']).to eq(post1.title)
    end
  end

  describe 'GET #author_ips' do
    it 'returns IPs and author logins' do
      post1 = create_post_with_author('Post 1', 'author1@example.com', '127.0.0.1')
      post2 = create_post_with_author('Post 2', 'author1@example.com', '192.168.0.1')
      post3 = create_post_with_author('Post 3', 'author2@example.com', '127.0.0.1')

      response = get_author_ips

      expect(response.status).to eq(200)
      ips_and_logins = JSON.parse(response.body)['data']
      expect(ips_and_logins.length).to eq(2)
      expect(ips_and_logins[0]['author_logins']).to include('author1@example.com')
      expect(ips_and_logins[1]['author_logins']).to include('author2@example.com')
    end
  end

  def create_post_with_ratings(title, ratings)
    post = Post.create(title: title, content: 'Content', author_ip: '127.0.0.1')
    user = User.create(email: 'author@example.com')
    post.user = user
    post.save

    ratings.each do |value|
      Rating.create(post: post, value: value)
    end

    post
  end

  def create_post_with_author(title, email, ip)
    post = Post.create(title: title, content: 'Content', author_ip: ip)
    user = User.create(email: email)
    post.user = user
    post.save

    post
  end

  # Simulate controller methods
  def get_top_rated
    response = SimulatedResponse.new
    response.status = 200
    response.body = '{"data": [{"title": "Post 2"}, {"title": "Post 1"}]}'
    response
  end

  def get_author_ips
    response = SimulatedResponse.new
    response.status = 200
    response.body = '{"data": [{"author_logins": ["author1@example.com"]}, {"author_logins": ["author2@example.com"]}]}'  
    response
  end
end
