class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_table :stations do |t|
      t.integer :company_id
      t.string :name
      t.string :city
    end

    add_index :stations, :company_id
    add_index :stations, :city
    add_index :stations, [:company_id, :name, :city], unique: true
  end
end
