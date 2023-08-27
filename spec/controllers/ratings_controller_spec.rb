require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  describe 'POST #create' do
    it 'creates a new rating and updates average rating' do
      post = Post.create(title: 'Test Post', content: 'Content', author_ip: '127.0.0.1')
      post.user = User.create(email: 'author@example.com')
      post.save

      post :create, params: { post_id: post.id, value: 4 }
      expect(response).to have_http_status(200)
      expect(post.reload.average_rating).to eq(4.0)
    end
  end
end
