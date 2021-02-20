class ChangeDatatypeBudgetOfEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :budget, :decimal, precision: 10, scale: 2
  end
end
