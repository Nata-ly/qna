class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  private

  def question
    @question ||= Question.find(params[:id])
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
