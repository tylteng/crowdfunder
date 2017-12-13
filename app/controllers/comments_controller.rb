class CommentsController < ApplicationController
  before_action :load_project

  def new
    @comment = Comment.new
  end

  def create
    @comment = @project.comments.build
    @comment.comment = params[:comment][:comment]
    @comment.user = current_user

    if @comment.save
      redirect_to project_url(@project), notice: 'Comment posted'
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to project_url(@project), notice: 'Comment successfully deleted.'
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
