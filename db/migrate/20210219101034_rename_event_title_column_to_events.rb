class RenameEventTitleColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :event_title, :title
  end
end
