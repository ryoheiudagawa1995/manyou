class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :authenticate_user

  def index
    if params[:sort_expired].present?
      @tasks = current_user.tasks.order(:limit).page(params[:page]).per(5)
    elsif params[:sort_priority_expired].present?
      @tasks = current_user.tasks.order(:priority).page(params[:page]).per(5)
    elsif params[:search].present?
      #@tasks = current_user.tasks.search(params[:title_search], params[:status_search], params[:label_id]).page(params[:page]).per(5)
      if params[:title_search].present? && params[:status_search].present?
        @tasks = current_user.tasks.where('title like? AND status like?', "%#{params[:title_search]}%", params[:status_search].to_s).page(params[:page]).per(5)
      elsif params[:title_search].present?
        @tasks = current_user.tasks.where('title like?', "%#{params[:title_search]}%").page(params[:page]).per(5)
      elsif params[:status_search].present?
        @tasks = current_user.tasks.where(status: params[:status_search]).page(params[:page]).per(5)
      elsif params[:label_ids][0].present?
          @tasks = []
        params[:label_ids].each do |label|
          @tasks += current_user.tasks.where(id: Labelling.where(label_id: label).pluck(:task_id))
        end
        @tasks = Kaminari.paginate_array(@tasks.uniq).page(params[:page]).per(5)
      else
        @tasks = current_user.tasks.order(created_at: :DESC).page(params[:page]).per(5)
      end
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
    params.require(:task).permit(:title, :limit, :status, :priority, :content, :user_id, label_ids: [])
  end

  def task_id_research

    params[:label_ids].each do |label|
      task_research = Labelling.where(label_id: label).pluck(:task_id)
    end

  end

end
