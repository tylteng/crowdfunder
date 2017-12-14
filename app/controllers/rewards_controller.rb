class RewardsController < ApplicationController
  before_action :load_project, except: :claim

  def new
    @reward = Reward.new
  end

  def create
    @reward = @project.rewards.build
    @reward.dollar_amount = params[:reward][:dollar_amount]
    @reward.limit = params[:reward][:limit]
    @reward.description = params[:reward][:description]

    if @reward.save
      redirect_to project_url(@project), notice: 'Reward created'
    else
      render :new
    end
  end

  def claim
    @reward = Reward.find(params[:id])
    @project_pledge_remaining = current_user.project_pledge_remaining[@reward.project_id]
    puts @project_pledge_remaining
    puts @reward.dollar_amount
    if @reward.limit > 0
      if @reward.dollar_amount <= @project_pledge_remaining
        @reward.limit -= 1
        @reward.users << current_user
        @reward.save
        puts @reward.inspect
          redirect_to user_path(current_user.id), notice: 'Reward claimed!'
      else
        redirect_to user_path(current_user.id), notice: 'Unable to claim reward. Pledge amount insufficient.'
      end
    else
      redirect_to user_path(current_user.id), notice: 'Reward sold out.'
    end
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
