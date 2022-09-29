class CommentsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def create
    @comment = resource.comments.create(comment_params.merge(user: current_user))
    unless @comment.errors.any?
      SendCommentJob.perform_later(@comment, resource_question_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def resource_question_id
    @resource.is_a?(Answer) ? @resource.question_id : @resource.id
  end

  def resource
    klass = [Question, Answer].detect { |klass| params["#{klass.name.underscore}_id"] }
    @resource = klass.find(params["#{klass.name.underscore}_id"])
  end
end
