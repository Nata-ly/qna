class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @answer = question.answers.create(answer_params.merge(user: current_user))
  end

  def destroy
    if current_user == answer.user
      answer.destroy
    else
      redirect_to answer.question
    end
  end

  def update
    answer.update(answer_params)
  end

  def mark_as_best
    @last_best_answers = answer.question.best_answer
    answer.question.update(best_answer_id: answer.id)
  end

  def destroy_file
    if current_user == answer.user
      @file = ActiveStorage::Attachment.find(params[:file_id])
      @file.purge
    end
  end

  def destroy_link
    if current_user == answer.user
      @link = Link.find(params[:link])
      @link.destroy
    end
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
