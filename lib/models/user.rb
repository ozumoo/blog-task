require 'active_record'


class User < ActiveRecord::Base
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
    has_many :posts
    has_many :feedbacks, foreign_key: :owner_id

    def to_json(*args)
      { email: email }.to_json(*args)
    end
  end
  