class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)
    if @submission.save
      flash[:notice] = "Thank you for your submission!"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:name, :tagline, :description, :website, :alternative_to, :suggested_tags, :github_url, :logo_url, :proprietary, :premium)
  end
end
