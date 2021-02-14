class RemoveStatusFromPlans < ActiveRecord::Migration[5.2]
  def change
    remove_column :plans, :status, :string
  end
end
