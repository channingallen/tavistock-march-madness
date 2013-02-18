class AddFacebookIndicesToUsers < ActiveRecord::Migration
  def change
    add_index :users, :fb_id
    add_index :users, :fb_access_token
  end
end