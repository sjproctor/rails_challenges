class AddApprovedToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :is_approved, :boolean, default: false
  end
end
