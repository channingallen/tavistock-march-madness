class AddFacebookColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_id, :string
    add_column :users, :gender, :string
    add_column :users, :timezone, :string
    add_column :users, :fb_username, :string
    add_column :users, :fb_access_token, :string
  end
end