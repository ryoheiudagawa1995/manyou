class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.string :limit
      t.string :status
      t.string :priority

      t.timestamps
    end
  end
end
