class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :author_name
      t.string :content
      t.integer :blog_post_id
      t.timestamps
    end
  end
end
