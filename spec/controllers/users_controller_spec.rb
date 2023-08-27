require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    it 'creates a new user' do
      post :create, params: { email: 'newuser@example.com' }
      expect(response).to have_http_status(200)
      expect(User.count).to eq(1)
    end
  end
end
