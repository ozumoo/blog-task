# app/workers/seeding_worker.rb

require 'sidekiq/api'
require 'sidekiq'


class SeedingWorker
    include Sidekiq::Worker
  
    BATCH_SIZE = 1000
  
    def perform(class_name, count)
      case class_name
      when 'User'
        create_users(count)
      when 'Post'
        create_posts(count)
      when 'Feedback'
        create_feedbacks(count)
      end
    end
  
    private
  
    def create_users(count)
      count.times do
        User.create(email: Faker::Internet.unique.email)
      end
    end
  
    def create_posts(count)
        ips = [
            "192.168.1.1",
            "10.0.0.1",
            "172.16.0.1",
            "192.168.0.1",
            "192.168.1.10",
            "192.168.1.100",
            "192.168.1.200",
            "192.168.2.1",
            "192.168.2.100",
            "192.168.10.1",
            "192.168.100.1",
            "192.168.254.1",
            "172.20.10.1",
            "172.31.0.1",
            "10.10.0.1",
            "10.1.1.1",
            "10.0.0.2",
            "10.0.0.3",
            "10.0.0.4",
            "10.0.0.5",
            "10.0.0.6",
            "10.0.0.7",
            "10.0.0.8",
            "10.0.0.9",
            "10.0.0.10",
            "192.168.0.2",
            "192.168.0.3",
            "192.168.0.4",
            "192.168.0.5",
            "192.168.0.6",
            "192.168.0.7",
            "192.168.0.8",
            "192.168.0.9",
            "192.168.0.10",
            "192.168.0.11",
            "192.168.0.12",
            "192.168.0.13",
            "192.168.0.14",
            "192.168.0.15",
            "192.168.0.16",
            "192.168.0.17",
            "192.168.0.18",
            "192.168.0.19",
            "192.168.0.20",
            "192.168.0.21",
            "192.168.0.22",
            "192.168.0.23",
            "192.168.0.24",
            "192.168.0.25",
            "192.168.0.26",
            "192.168.0.27",
            "192.168.0.28",
            "192.168.0.29",
            "192.168.0.30"
          ]
  
      User.find_each do |author|
        (count / BATCH_SIZE).times do
          Post.transaction do
            BATCH_SIZE.times do
              Post.create!(
                title: Faker::Lorem.sentence,
                content: Faker::Lorem.paragraphs(number: 3).join("\n"),
                author_ip: ips.sample,
                user: author
              )
            end
          end
        end
      end
    end
  
    def create_feedbacks(count)
      User.find_each do |user|
        (count / BATCH_SIZE).times do
          Feedback.transaction do
            BATCH_SIZE.times do
              Feedback.create!(
                user: user,
                comment: Faker::Lorem.sentence
              )
            end
          end
        end
      end
    end
  end
  