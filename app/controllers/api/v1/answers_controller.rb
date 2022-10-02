class Api::V1::AnswersController < Api::V1::BaseController
  skip_authorization_check

  def index
    @answers = question.answers
    render json: @answers
  end

  def show
    render json: answer, serializer: AnswerSeparateSerializer
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end
end
