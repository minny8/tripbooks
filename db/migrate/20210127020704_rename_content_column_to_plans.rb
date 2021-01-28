class RenameContentColumnToPlans < ActiveRecord::Migration[5.2]
  def change
    rename_column :plans, :content, :destination
  end
end
