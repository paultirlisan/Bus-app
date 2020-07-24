class CreateJourneys < ActiveRecord::Migration[6.0]
  def change
    create_table :journeys do |t|
      t.integer :user_id
      t.integer :route_id
      t.datetime :date
    end

    add_index :journeys, :user_id
    add_index :journeys, [:route_id, :date]
  end
end
