class AddTaskToLabels < ActiveRecord::Migration[5.2]
  def change
    add_reference :labels, :task, foreign_key: true
  end
end
