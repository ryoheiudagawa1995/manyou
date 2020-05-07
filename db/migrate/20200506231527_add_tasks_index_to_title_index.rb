class AddTasksIndexToTitleIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :title
    add_index :tasks, :status
  end
end
