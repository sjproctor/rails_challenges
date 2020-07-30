class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.text :answer
      t.boolean :mult_choice

      t.timestamps
    end
  end
end
