require 'json'
require_relative '../models/feedback'

class FeedbacksApp
  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new

    case @request.path
    when '/feedbacks'
      if @request.request_method == 'POST'
        handle_create
      elsif @request.request_method == 'GET'
        handle_index
      else
        not_found
      end
    else
      not_found
    end

    @response.finish
  end

  private

  def handle_create
    params = JSON.parse(@request.body.read)
    feedback = Feedback.new(
      user_id: params['user_id'],
      comment: params['comment']
    )

    if feedback.save
      json_response({ success: true }, 200)
    else
      json_response({ success: false, errors: feedback.errors.full_messages }, 422)
    end
  end

  def handle_index
    user_id = @request.params['user_id']
    feedbacks = Feedback.where(user_id: user_id).order(created_at: :desc)
    json_response(feedbacks.map { |feedback| { id: feedback.id, comment: feedback.comment } }, 200)
  end

  def not_found
    @response.status = 404
    @response.write('Not Found')
  end

  def json_response(data, status)
    @response.status = status
    @response['Content-Type'] = 'application/json'
    @response.write(JSON.generate(data))
  end
end
