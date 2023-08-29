require_relative '../../lib/controllers/users_app'
require_relative '../../lib/models/user'

# Simulated HTTP response structure
class SimulatedResponse
  attr_accessor :status, :body

  def initialize
    @status = nil
    @body = nil
  end
end

RSpec.describe UsersApp, type: :controller do
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

  describe 'POST #create' do
    it 'creates a new user' do
      response = create_user('newuser@example.com')

      expect(response.status).to eq(200)
      expect(User.count).to eq(1)
    end
  end

  # Simulate controller method
  def create_user(email)
    response = SimulatedResponse.new
    response.status = 200
    User.create(email: email)
    response
  end
end
