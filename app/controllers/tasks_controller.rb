class TasksController < ApplicationController
	def new
		@task = Task.new
  end
  def index
  	@task = Task.new
  	@tasks = Task.all
  end
  def create  
  	@task = Task.new(params[:task].permit(:task))
    if @task.save
    	redirect_to tasks_url, :notice => 'Your task has successfully been added.'
    else
    	redirect_to :back, :notice => 'There was an error adding your task.'
    end
  end  

  def edit
  	@task = Task.find(params[:id])
  end

  def update
  	task = Task.find(params[:id])
  	if task.update(params[:task].permit(:task))
  		redirect_to tasks_path, :notice => 'Your task has successfully been updated.'
  	else  		
  		redirect_to :back, :notice => 'There was an error updating your task.'
  	end
  end

  def destroy
  	Task.destroy params[:id]
  	redirect_to :back, :notice => 'Your task has successfully been deleted.'
  end

  private
		def task_params
		  params.require(:task).permit(:task)
		end
end
