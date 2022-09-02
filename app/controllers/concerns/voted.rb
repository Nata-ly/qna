module Voted
  extend ActiveSupport::Concern

  def vote_positive
    return render_errors("can't vote") if votable.user == current_user
    if user_voted?
      render_errors('you have already voted')
    else
      current_user.votes.create(votable: votable, solution: true)
      render_json_value
    end
  end

  def vote_negative
    return render_errors("can't vote") if votable.user == current_user
    if user_voted?
      render_errors('you have already voted')
    else
      current_user.votes.create(votable: votable, solution: false)
      render_json_value
    end
  end

  def cancel_voice
    return render_errors("can't vote") if votable.user == current_user
    if user_voted?
      current_user.votes.find_by(votable: votable).destroy
      render_json_value
    else
      render_errors('you have not voted')
    end
  end

  private

  def render_errors(message)
    render json: { message: message }, status: :unprocessable_entity
  end

  def render_json_value
    render json: { value: votable.vote_value }, status: :ok
  end

  def model_klass
    controller_name.classify.constantize
  end

  def votable
    @votable ||= model_klass.find(params[:id])
  end

  def user_voted?
    !current_user.votes.where(votable: votable).count.zero?
  end
end
