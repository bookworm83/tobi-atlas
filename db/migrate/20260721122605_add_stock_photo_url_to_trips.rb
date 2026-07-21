class AddStockPhotoUrlToTrips < ActiveRecord::Migration[8.1]
  def change
    add_column :trips, :stock_photo_url, :string
  end
end
