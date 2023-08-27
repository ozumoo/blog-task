require 'webrick'
require_relative '../models/feedback' # Adjust the path accordingly

class FeedbacksController < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)
    case request.path
    when '/feedbacks'
      handle_create(request, response)
    else
      response.status = 404
      response.body = 'Not Found'
    end
  end

  def do_GET(request, response)
    case request.path
    when '/feedbacks'
      handle_index(request, response)
    else
      response.status = 404
      response.body = 'Not Found'
    end
  end

  private

  def handle_create(request, response)
    params = JSON.parse(request.body)
    feedback = Feedback.new(
      user_id: params['user_id'],
      post_id: params['post_id'],
      comment: params['comment']
    )

    if feedback.save
      response.status = 200
      response['Content-Type'] = 'application/json'
      response.body = { data: feedback }.to_json
    else
      response.status = 422
      response['Content-Type'] = 'application/json'
      response.body = { errors: feedback.errors.full_messages }.to_json
    end
  end

  def handle_index(request, response)
    user_id = request.query['user_id']
    feedbacks = Feedback.where(user_id: user_id).order(created_at: :desc)

    response.status = 200
    response['Content-Type'] = 'application/json'
    response.body = { data: feedbacks }.to_json
  end
end