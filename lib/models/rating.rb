class Rating < ActiveRecord::Base
    belongs_to :post
  
    validates :value, presence: true, inclusion: { in: 1..5 }
  end
  