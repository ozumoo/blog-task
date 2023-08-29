require 'faker'
require 'active_record'
require 'logger'
require 'sidekiq/api'
require_relative '../lib/workers/seeding_worker'


# db/seeds.rb

seeding_worker = Sidekiq::HardWorker.new

# # Create 100 authors (users)
seeding_worker.perform('User', 100)
puts "user seeder done"

# # Create posts
seeding_worker.perform('Post', 2000)
puts "Post seeder done"

# Create 50 users
seeding_worker.perform('Feedback', 50)
puts "Feedback seeder done"

# # Create feedbacks for posts
seeding_worker.perform('Feedback', 20)
