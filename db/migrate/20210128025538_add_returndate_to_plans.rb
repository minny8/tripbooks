class AddReturndateToPlans < ActiveRecord::Migration[5.2]
  def change
    rename_column :plans, :date, :departure_date
    add_column :plans, :return_date, :date
  end
end
