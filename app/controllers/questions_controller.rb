class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @questions = Question.all
  end

  def show
    @best_answer = question.best_answer
    @other_answers = question.answers.where.not(id: question.best_answer_id)
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    if current_user == question.user
      question.destroy

      redirect_to questions_path, notice: 'Your question successfully destroy.'
    end
  end

  def update
    question.update(question_params)
  end

  private

  def question
    @question ||= Question.with_attached_files.find(params[:id])
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body, files: [])
  end
end
