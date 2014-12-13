require 'spec_helper'
require 'rails_helper'

module ::RSpec::Core
  class ExampleGroup
    include Capybara::DSL
    include Capybara::RSpecMatchers
  end
end

Capybara.default_wait_time = 30

RSpec.describe "Tasks", :type => :request do
  before do
  	@task = Task.create :task => 'go to bed'
  end

  describe "GET /tasks" do
    it "display some tasks" do
    	@task = Task.create :task => 'go to bed'
    	visit tasks_path
    	page.should have_content 'go to bed'
    end
    it "create a new task" do
    	visit tasks_path
    	fill_in 'Task', :with => 'go to work'
    	click_button 'Create Task'

    	current_path.should == tasks_path
    	page.should have_content("go to work")

    	save_and_open_page
    end
    it "edits a task" do
	    visit tasks_path
	    click_link 'Edit'

	    current_path.should == edit_task_path(@task)

			save_and_open_page	    
			
			#page.should have_content 'go to bed'	    
			find_field("Task").value.should == 'go to bed'
			

			fill_in 'Task', :with => 'test task'
			click_button 'Update Task'

			current_path.should == tasks_path

			page.should have_content("test task")
		end

		it "should not update an empty task" do
			visit tasks_path
	    click_link 'Edit'

	    current_path.should == edit_task_path(@task)

			save_and_open_page	    
			
			#page.should have_content 'go to bed'	    
			find_field("Task").value.should == 'go to bed'
			

			fill_in 'Task', :with => ''
			click_button 'Update Task'
			current_path.should == edit_task_path(@task)

			page.should have_content("There was an error updating your task")
		end
	end
	describe "GET /tasks" do
		it "should delete a task" do
			visit tasks_path
			find("#task_#{@task.id}").click_link 'Delete'

			page.should have_content("Your task has successfully been deleted.")
			page.should have_no_content("go to bed")

		end
  end  
end
