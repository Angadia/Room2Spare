class AddOneHourRentalPriceToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :one_hour_rental_price, :integer
    remove_column :availabilities, :one_hour_rental_price
  end
end
