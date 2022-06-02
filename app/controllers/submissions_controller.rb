class SubmissionsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :set_submission, only: [:destroy]
  before_action :is_user_admin, only: [:destroy]

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

  def destroy
    if @submission.destroy
      redirect_to site_admin_home_path, flash: {notice: "Submission deleted sucessfully"}
    else
      redirect_to site_admin_home_path, flash: {alert: "Issues: #{@submission.errors.full_messages}"}
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:name, :tagline, :description, :website, :alternative_to, :suggested_tags, :github_url, :logo_url, :proprietary, :premium)
  end

  def set_submission
    @submission = Submission.find(params[:id])
  end
end
