class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.integer :company_id
      t.integer :departure_station_id
      t.integer :arrival_station_id
      t.string :name
      t.integer :duration
      t.float :distance
      t.datetime :start_date
      t.datetime :end_date
      t.integer :period
      t.float :price
      t.integer :capacity
    end

    add_index :routes, :company_id, name: "first_index"
    add_index :routes, [:departure_station_id, :arrival_station_id], name: "second_index"
    add_index :routes, [:departure_station_id, :arrival_station_id, :duration], name: "third_index"
    add_index :routes, [:departure_station_id, :arrival_station_id, :price], name: "fourth_index"
    add_index :routes, [:departure_station_id, :arrival_station_id, :duration, :price], name: "fifth_index"
    add_index :routes, [:departure_station_id, :arrival_station_id, :company_id], name: "sixth_index"
    add_index :routes, [:departure_station_id, :arrival_station_id, :duration, :company_id], name: "seventh_index"
    add_index :routes, [:departure_station_id, :arrival_station_id, :price, :company_id], name: "eigth_index"
    add_index :routes, [:departure_station_id, :arrival_station_id, :duration, :price, :company_id], name: "ninth_index"
    add_index :routes, [:departure_station_id, :arrival_station_id, :name], unique: true, name: "tenth_index"
  end
end
