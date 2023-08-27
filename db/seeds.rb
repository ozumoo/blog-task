require 'faker'
require 'active_record'
require 'sidekiq/api'
require_relative '../lib/workers/seeding_worker'


# db/seeds.rb

# Create 50 users using Sidekiq
SeedingWorker.perform_async('User', 50)

# Create 100 authors (users) using Sidekiq
SeedingWorker.perform_async('User', 100)

# Create posts using Sidekiq
SeedingWorker.perform_async('Post', 200_000)

# Create feedbacks for posts using Sidekiq
SeedingWorker.perform_async('Feedback', 10_000)

# Create feedbacks for users using Sidekiq
SeedingWorker.perform_async('Feedback', 50)
