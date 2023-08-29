require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  describe 'POST #create' do
    it 'creates a new feedback' do
      post :create, params: { user_id: 1, comment: 'Great post!' }
      expect(response).to have_http_status(200)
      expect(Feedback.count).to eq(1)
    end
  end

  describe 'GET #index' do
    it 'returns feedbacks for the same owner' do
      owner = User.create(email: 'owner@example.com')
      feedback1 = Feedback.create(owner: owner, comment: 'Comment 1')
      feedback2 = Feedback.create(owner: owner, comment: 'Comment 2')

      get :index, params: { user_id: owner.id }
      expect(response).to have_http_status(200)
      expect(response.body).to include(feedback1.comment)
      expect(response.body).to include(feedback2.comment)
    end
  end
end
