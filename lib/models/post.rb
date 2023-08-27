require 'active_record'


class Post < ActiveRecord::Base

    # ... other attributes ...
    attr_accessor :average_rating

    belongs_to :user
    has_many :ratings
    has_many :feedbacks
  
    validates :title, :content, presence: true
  end
  