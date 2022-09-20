class SendAnswerJob < ApplicationJob
  queue_as :default

  def perform(answer)
    html = ApplicationController.render(
      partial: 'answers/answer_abbreviated',
      locals: { answer: answer }
    )

    ActionCable.server.broadcast "answers_channel_with_question_#{answer.question.id}",
                                 html: html, user: answer.user.id
  end
end
