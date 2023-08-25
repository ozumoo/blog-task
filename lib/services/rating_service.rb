class RatingService
    def self.rate_post(post_id, value)
      post = Post.find(post_id)
      rating_value = value.to_i
  
      new_rating = Rating.create(post: post, value: rating_value)
  
      if new_rating.valid?
        update_average_rating(post)
        post.average_rating
      else
        nil
      end
    rescue ActiveRecord::StaleObjectError
      # Handle concurrency conflict
      nil
    end
  
    private
  
    def self.update_average_rating(post)
      post.with_lock do
        post.reload
        post.update(average_rating: post.ratings.average(:value))
      end
    end
  end
  