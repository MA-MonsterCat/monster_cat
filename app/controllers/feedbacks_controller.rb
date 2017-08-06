class FeedbacksController < ApplicationController
  def new
    @workshop = workshop
    @feedback = Feedback.new
  end

  def create
    binding.pry
    feedback = Feedback.new(permitted_params.merge(workshop: workshop))
    if feedback.valid?
      feedback.save
      flash[:notice] = 'Feedback added'
      redirect_to workshop_path(workshop)
    else
      flash[:error] = "Feedback was not added: #{feedback.errors}"
      redirect_to new_workshop_feedback_path(feedback, workshop)
    end
  end

  private

  def workshop
    Workshop.find(params[:workshop_id])
  end

  def permitted_params
    params.require(:feedback).permit(:body)
  end
end
