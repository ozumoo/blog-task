require 'json'
require_relative '../models/feedback' # Adjust the path accordingly

class FeedbacksApp
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

    case request.path
    when '/feedbacks'
      if request.request_method == 'POST'
        handle_create(request, response)
      elsif request.request_method == 'GET'
        handle_index(request, response)
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

  def create(user_id, comment)
    feedback = Feedback.new(user_id: user_id, comment: comment)
    feedback.save
  end

  def index(user_id)
    feedbacks = Feedback.where(user_id: user_id)
    feedbacks.map { |feedback| { id: feedback.id, comment: feedback.comment } }
  end

  private

  def handle_create(request, response)
    params = JSON.parse(request.body.read)
    feedback = Feedback.new(
      user_id: params['user_id'],
      post_id: params['post_id'],
      comment: params['comment']
    )

    if feedback.save
      response.status = 200
      response['Content-Type'] = 'application/json'
      response.write({ success: true }.to_json)
    else
      response.status = 422
      response['Content-Type'] = 'application/json'
      response.write({ success: false, errors: feedback.errors.full_messages }.to_json)
    end
  end

  def handle_index(request, response)
    user_id = request.params['user_id']
    feedbacks = Feedback.where(user_id: user_id).order(created_at: :desc)

    response.status = 200
    response['Content-Type'] = 'application/json'
    response.write(feedbacks.to_json)  # Write the fetched data directly
  end
end