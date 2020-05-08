class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.date :limit, default: '2020/12/31'
      t.string :status, default: '未着手'
      t.integer :priority

      t.timestamps
    end
  end
end
