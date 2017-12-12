class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)
    
    if params[:search]
     @searchedprojects = Project.search(params[:search]).order(:end_date)
    else
     @searchedprojects = Project.all.order(:end_date)
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
    @project.rewards.build
  end

  def create
    @project = Project.new
    @project.title = params[:project][:title]
    @project.description = params[:project][:description]
    @project.goal = params[:project][:goal]
    @project.start_date = params[:project][:start_date]
    @project.end_date = params[:project][:end_date]
    @project.image = params[:project][:image]
    @project.user = current_user

    @project.user = current_user
    categories = params[:project][:category_ids]
    categories.delete("")

    categories.each do |id|
      @project.categories << Category.find_by(id: id.to_i)
    end





    if @project.save
      redirect_to projects_url
    else
      render :new
    end


end


end
