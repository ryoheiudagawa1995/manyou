class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :labels, :user_id, defalut: nil
  end
end
