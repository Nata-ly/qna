class AnswersController < ApplicationController
  def create
    @answer = question.answers.build(answer_params)

    if @answer.save
      redirect_to question
    else
      render 'questions/show'
    end
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
