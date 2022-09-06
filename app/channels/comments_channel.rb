class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comment_channel_with_question_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
