require 'active_record'
require 'dotenv/load'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: ENV['DATABASE_HOST'],
  username: ENV['DATABASE_USERNAME'],
  password: ENV['DATABASE_PASSWORD'],
  database: ENV['DATABASE_NAME']
)
