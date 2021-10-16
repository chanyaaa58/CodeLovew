class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :name, null: false
      t.string :title, null: false
      t.string :problem, null: false
      t.string :detail, null: false
      t.string :solution
      t.text :content, null: false

      t.timestamps
    end
  end
end
