class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  include Voted

  authorize_resource

  def index
    @questions = Question.all
  end

  def show
    @best_answer = question.best_answer
    @other_answers = question.answers.where.not(id: question.best_answer_id)
    @answer = Answer.new
    @answer.links.new
    @subscription = question.subscriptions.find_by(user: current_user)
  end

  def new
    @question = Question.new
    @question.links.new
    @question.build_reward
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      ActionCable.server.broadcast 'questions_channel',
                                   @question
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
    @subscription = question.subscriptions.find_by(user: current_user)
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
    @question ||= Question.with_attached_files.find(params[:id])
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:id, :name, :url, :_destroy], reward_attributes: [:title, :image])
  end
end
