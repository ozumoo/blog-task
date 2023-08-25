class PostsController
    def create
      user = User.find_or_create_by(email: params[:author_email])
      post = user.posts.build(title: params[:title], content: params[:content], author_ip: params[:author_ip])
  
      if post.save
        render_json(post, 200)
      else
        render_errors(post.errors.full_messages, 422)
      end
    end

    def top_rated
        n = params[:n].to_i
        top_posts = Post.order(average_rating: :desc).limit(n)
        
        render_json(top_posts, 200)
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
  