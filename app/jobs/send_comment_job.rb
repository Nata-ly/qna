class SendCommentJob < ApplicationJob
  queue_as :default

  def perform(comment, question_id)
    html = ApplicationController.render(
      partial: 'comments/comment',
      locals: { comment: comment }
    )

    ActionCable.server.broadcast "comment_channel_with_question_#{question_id}",
                                 html: html, user: comment.user.id, comment: comment
  end
end
