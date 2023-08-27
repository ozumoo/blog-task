require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #top_rated' do
    it 'returns top N posts by average rating' do
      # Create posts with ratings
      post1 = create_post_with_ratings('Post 1', [4, 5, 3, 4])
      post2 = create_post_with_ratings('Post 2', [3, 4, 5, 5])
      post3 = create_post_with_ratings('Post 3', [2, 2, 1, 1])

      get :top_rated, params: { n: 2 }
      expect(response).to have_http_status(200)
      top_posts = JSON.parse(response.body)['data']
      expect(top_posts.length).to eq(2)
      expect(top_posts[0]['title']).to eq(post2.title)
      expect(top_posts[1]['title']).to eq(post1.title)
    end
  end

  describe 'GET #author_ips' do
    it 'returns IPs and author logins' do
      # Create posts
      post1 = create_post_with_author('Post 1', 'author1@example.com', '127.0.0.1')
      post2 = create_post_with_author('Post 2', 'author1@example.com', '192.168.0.1')
      post3 = create_post_with_author('Post 3', 'author2@example.com', '127.0.0.1')

      get :author_ips
      expect(response).to have_http_status(200)
      ips_and_logins = JSON.parse(response.body)['data']
      expect(ips_and_logins.length).to eq(2)
      expect(ips_and_logins[0]['author_logins']).to include('author1@example.com')
      expect(ips_and_logins[1]['author_logins']).to include('author2@example.com')
    end
  end

  # Helper methods

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
end
