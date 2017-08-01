class ChangeCompletedOnItem < ActiveRecord::Migration[5.1]
  def change
    change_column_default :items, :completed, from: nil, to: false
  end
end
