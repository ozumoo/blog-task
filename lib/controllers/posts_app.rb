require 'json'
require_relative '../models/user' # Adjust the path accordingly
require_relative '../models/post' # Adjust the path accordingly

class PostsApp
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

    case request.path
    when '/posts/top_rated'
      handle_top_rated(request, response)
    when '/posts'
      if request.request_method == 'POST'
        handle_create(request, response)
      else
        response.status = 404
        response.write('Not Found')
      end
    else
      response.status = 404
      response.write('Not Found')
    end

    response.finish
  end

  private

  def handle_top_rated(request, response)
    n = request.params['n'].to_i
    top_posts = Post.order(average_rating: :desc).limit(n)

    response.status = 200
    response['Content-Type'] = 'application/json'
    response.write(top_posts.to_json)
  end

  def handle_create(request, response)
    params = JSON.parse(request.body.read)

    user = User.find_or_create_by(email: params['author_email'])

    post = user.posts.build(
      title: params['title'],
      content: params['content'],
      author_ip: params['author_ip']
    )

    if post.save
      response.status = 200
      response['Content-Type'] = 'application/json'
      response.write(post.to_json)
    else
      response.status = 422
      response['Content-Type'] = 'application/json'
      response.write({ errors: post.errors.full_messages }.to_json)
    end
  end
end
