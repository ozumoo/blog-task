require 'builder'

class FeedbackExportWorker
  include Sidekiq::Worker

  def perform
    feedbacks = Feedback.all
    xml_data = build_xml(feedbacks)

    File.open('feedbacks.xml', 'w') do |file|
      file.write(xml_data)
    end
  end

  private

  def build_xml(feedbacks)
    xml = Builder::XmlMarkup.new(indent: 2)
    xml.instruct!
    
    xml.feedbacks do
      feedbacks.each do |feedback|
        xml.feedback do
          xml.owner_login feedback.owner.email
          xml.comment feedback.comment
          xml.rating feedback.rating || ''
          xml.feedback_type feedback.user_id ? 'user' : 'post'
        end
      end
    end

    xml.target!
  end
end
