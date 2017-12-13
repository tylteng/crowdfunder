class UpdatesController < ApplicationController
  before_action :load_project

  def new
    @update = Update.new
  end

  def create
    @update = @project.updates.build
    @update.description = params[:update][:description]

    if @update.save
      redirect_to project_url(@project), notice: 'Update posted'
    else
      render :new
    end
  end


  def destroy
    @update = Update.find(params[:id])
    @update.destroy

    redirect_to project_url(@project), notice: 'Update successfully deleted.'
  end



  def load_project
    @project = Project.find(params[:project_id])
  end


end
