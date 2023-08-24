require 'rake'
require 'active_record'
require_relative 'config/database'

namespace :db do
  desc 'Create the database'
  task :create do
    ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      host: ENV['DATABASE_HOST'],
      username: ENV['DATABASE_USERNAME'],
      password: ENV['DATABASE_PASSWORD']
    )
    ActiveRecord::Base.connection.create_database(ENV['DATABASE_NAME'], charset: 'utf8mb4', collation: 'utf8mb4_unicode_ci')
  end

  desc 'Migrate the database'
  task :migrate do
    ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      host: ENV['DATABASE_HOST'],
      username: ENV['DATABASE_USERNAME'],
      password: ENV['DATABASE_PASSWORD']
      database: 'your_database_name'
    )
    ActiveRecord::Migrator.migrate('db/migrate')
  end

  desc 'Seed the database'
  task :seed do
    load 'db/seeds.rb'
  end

  desc 'Reset the database'
  task :reset => [:create, :migrate, :seed]
end

task :default => [:db]
