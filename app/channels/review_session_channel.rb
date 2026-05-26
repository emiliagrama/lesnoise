class ReviewSessionChannel < ApplicationCable::Channel
  def subscribed
    review_session = ReviewSession.find_by(id: params[:review_session_id])

    reject unless review_session

    stream_from "review_session_#{review_session.id}"
  end

  def unsubscribed
  end
end