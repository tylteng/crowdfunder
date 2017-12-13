class RewardsController < ApplicationController
  before_action :load_project, except: :claim

  def new
    @reward = Reward.new
  end

  def create
    @reward = @project.rewards.build
    @reward.dollar_amount = params[:reward][:dollar_amount]
    @reward.description = params[:reward][:description]

    if @reward.save
      redirect_to project_url(@project), notice: 'Reward created'
    else
      render :new
    end
  end

  def claim
    @reward = Reward.find(params[:id])
    @reward.limit -= 1
    @reward.users << current_user
    redirect_to user_path(current_user.id)
  end

  def destroy
    @reward = Reward.find(params[:id])
    @reward.destroy

    redirect_to project_url(@project), notice: 'Reward successfully removed'
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end
end
