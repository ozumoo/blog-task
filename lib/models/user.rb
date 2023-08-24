class User < ActiveRecord::Base
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
    has_many :posts
    has_many :feedbacks, foreign_key: :owner_id
  end
  