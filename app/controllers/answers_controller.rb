class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  include Voted

  authorize_resource

  def create
    @answer = question.answers.create(answer_params.merge(user: current_user))
    SendAnswerJob.perform_later(@answer) if @answer.errors.empty?
  end

  def destroy
    answer.destroy
  end

  def update
    answer.update(answer_params)
  end

  def mark_as_best
    @last_best_answers = answer.question.best_answer
    answer.question.update(best_answer_id: answer.id)
    if answer.question.reward
      answer.question.reward.update(user: answer.user)
    end
  end

  def destroy_file
    @file = ActiveStorage::Attachment.find(params[:file_id])
    @file.purge
  end

  def destroy_link
    @link = Link.find(params[:link])
    @link.destroy
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end

  helper_method :question

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:id, :name, :url, :_destroy])
  end
end
