class FeedbacksController
    def create
      feedback = Feedback.new(
        owner_id: params[:owner_id],
        user_id: params[:user_id],
        post_id: params[:post_id],
        comment: params[:comment]
      )
      
      if feedback.save
        render_json(feedback, 200)
      else
        render_errors(feedback.errors.full_messages, 422)
      end
    end
  
    def index
      owner_id = params[:owner_id]
      feedbacks = Feedback.where(owner_id: owner_id).order(created_at: :desc)
      
      render_json(feedbacks, 200)
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
  