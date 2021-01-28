class AddDateToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :date, :date
    add_column :plans, :status, :string
  end
end
