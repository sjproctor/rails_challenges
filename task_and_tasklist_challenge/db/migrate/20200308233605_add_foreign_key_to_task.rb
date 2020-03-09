class AddForeignKeyToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :tasklist_id, :integer
  end
end
