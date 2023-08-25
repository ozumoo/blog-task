class UsersController
    def create
      user = User.new(email: params[:email])
      
      if user.save
        render_json(user, 200)
      else
        render_errors(user.errors.full_messages, 422)
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
  