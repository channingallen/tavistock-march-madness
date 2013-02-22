class AddContestFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :contact_allowed, :boolean, :default => true, :null => false
    add_column :users, :restaurant_id, :string
  end
end
