class AddFieldsToTrips < ActiveRecord::Migration[8.1]
  def change
    add_column :trips, :start_date, :date
    add_column :trips, :end_date, :date
    add_column :trips, :notes, :text
  end
end
