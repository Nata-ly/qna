class Api::V1::QuestionsController < Api::V1::BaseController
  skip_authorization_check

  def index
    @questions = Question.all
    render json: @questions
  end

  def show
    render json: question, serializer: QuestionSeparateSerializer
  end

  private

  def question
    @question ||= Question.find(params[:id])
  end
end
