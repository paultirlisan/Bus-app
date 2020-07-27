class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :company_id
      t.integer :rating
      t.string :body
    end

    add_index :reviews, :company_id
    add_index :reviews, [:user_id, :company_id], unique: true
  end
end
