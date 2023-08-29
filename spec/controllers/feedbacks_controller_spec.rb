require 'active_record'
require_relative '../../lib/controllers/feedbacks_app'
require_relative '../../lib/models/post'
require_relative '../../lib/models/user'
require_relative '../../lib/models/feedback'

# Initialize ActiveRecord and establish database connection
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

RSpec.describe FeedbacksApp, type: :controller do
  before(:all) do
    # Create database tables (assuming you have migration files)
    ActiveRecord::Schema.verbose = false
    load 'db/schema.rb'  
  end 

  describe 'POST #create' do
    it 'creates a new feedback' do

      @owner = User.create(email: 'owner@example.com')

      feedbacks_app = FeedbacksApp.new
      # Perform the necessary setup here
      post = Post.create(user_id: 1 , title: 'Test Post', content: 'Content', author_ip: '127.0.0.1')
      
      result = feedbacks_app.create(1, "test")
      # Assertions for the POST action
      expect(Feedback.count).to eq(1)
    end
  end

  describe 'GET #index' do
    before(:each) do
      @owner = User.create(email: 'owner@example.com')
      @feedback1 = Feedback.create(user_id: @owner.id, comment: 'Comment 1')
      @feedback2 = Feedback.create(user_id: @owner.id, comment: 'Comment 2')
    end

    it 'returns feedbacks for the same owner' do
      # Perform the necessary setup here
      feedbacks_app = FeedbacksApp.new
      result = feedbacks_app.index(@owner.id)

      # Assertions for the GET action
      expect(result).to include({ id: @feedback1.id, comment: @feedback1.comment })
      expect(result).to include({ id: @feedback2.id, comment: @feedback2.comment })
    end
  end
end
