class CreateBlogPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.date :publish_date

      t.timestamps
    end
  end
end
