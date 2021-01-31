class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :event_title
      t.time :start_time
      t.time :end_time
      t.string :tel
      t.text :url
      t.string :address
      t.string :currency
      t.decimal :budget
      t.text :memo
      t.references :plan, foreign_key: true

      t.timestamps
    end
  end
end
