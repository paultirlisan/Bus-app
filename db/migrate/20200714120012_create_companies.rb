class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.integer :user_id
      t.text :description
      t.string :phone
      t.string :headquarters
      t.text :careers_advertisement
      t.boolean :active, default: true
    end

    add_index :companies, :user_id
  end
end
