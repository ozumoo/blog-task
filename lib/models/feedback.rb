class Feedback < ActiveRecord::Base
    belongs_to :owner, class_name: 'User'
    belongs_to :user
    belongs_to :post
  
    validates :comment, presence: true
  end
  