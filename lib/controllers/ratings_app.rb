require 'json'
require_relative '../services/rating_service'

class RatingsApp
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    case request.path
    when '/ratings'
      handle_create(request, response)
    else
      response.status = 404
      response.write('Not Found')
    end
    response.finish
  end

  def create(post_id, value)
    post = Post.find_by(id: post_id)
    
    if post
      Rating.create(post: post, value: value)
      update_average_rating(post)
      true 
    else
      false 
    end
  end

  def handle_create(request, response)
    params = JSON.parse(request.body.read)
    average_rating = RatingService.rate_post(params['post_id'], params['value'])

    if average_rating.nil?
      response.status = 422
      response['Content-Type'] = 'application/json'
      response.write({ errors: ['Error occurred while rating the post'] }.to_json)
    else
      response.status = 200
      response['Content-Type'] = 'application/json'
      response.write({ data: average_rating }.to_json)
    end
  end

  def update_average_rating(post)
    post.with_lock do
      post.update(average_rating: post.ratings.average(:value))
    end
  end
end
