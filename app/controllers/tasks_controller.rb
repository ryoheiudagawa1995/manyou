class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :authenticate_user

  def index
    if params[:sort_expired].present?
      @tasks = current_user.tasks.order(:limit).page(params[:page]).per(5)
    elsif params[:sort_priority_expired].present?
      @tasks = current_user.tasks.order(:priority).page(params[:page]).per(5)
    elsif params[:search].present?
      @tasks = current_user.tasks.search(params[:title_search], params[:status_search]).page(params[:page]).per(5)
    else
      @tasks = current_user.tasks.order(created_at: :DESC).page(params[:page]).per(5)
    end
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :limit, :status, :priority, :content)
  end
end
