class RatingsController
    def create
      average_rating = RatingService.rate_post(params[:post_id], params[:value])
      
      if average_rating.nil?
        render_errors(['Error occurred while rating the post'], 422)
      else
        render_json(average_rating, 200)
      end
    end
  
    private
  
    def render_json(data, status)
      response = { data: data, status: status }
      [status, { 'Content-Type' => 'application/json' }, [response.to_json]]
    end
  
    def render_errors(errors, status)
      response = { errors: errors, status: status }
      [status, { 'Content-Type' => 'application/json' }, [response.to_json]]
    end
  end
  