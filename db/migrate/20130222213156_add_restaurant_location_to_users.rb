class AddRestaurantLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :restaurant_location, :string
  end
end
