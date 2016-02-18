class TasksController < ApplicationController

  before_action :find_user
  before_action :find_category, except: [:all, :destroy, :update]

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def index
     @tasks = @category.tasks
  end

  def all
    @tasks = @current_user.tasks
  end

  def create
    @task = @category.tasks.new task_params
    @task.user = @current_user
    unless @task.save
      @messages = @task.errors.full_messages
      render status: :conflict, template: 'layouts/errors'
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.attributes = task_params

    unless @task.save
      @messages = @task.errors.full_messages
      render status: :conflict, template: 'layouts/errors'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  end

  private
  def task_params
    params.permit(:title, :description, :end, :ready)
  end

  def find_category
    @category = Category.find params[:category_id]
    unless @category
      @messages = ['CategoryNotFound']
      render status: :conflict, template: 'layouts/errors'
    end
  end

  def record_not_found
    @messages = ['TaskNoFound']
    render status: :conflict, template: 'layouts/errors'
  end
end
