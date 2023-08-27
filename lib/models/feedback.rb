require 'active_record'


class Feedback < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
  
    validates :comment, presence: true
  end
  