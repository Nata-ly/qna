class AnswersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "answers_channel_with_question_#{params[:room]}"
  end

  def unsubscribed
  end
end
