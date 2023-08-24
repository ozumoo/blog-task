class Post < ActiveRecord::Base
    belongs_to :user
    has_many :ratings
    has_many :feedbacks
  
    validates :title, :content, presence: true
  end
  