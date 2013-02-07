class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.boolean :is_official, :default => false
      t.integer :user_id

      t.timestamps
    end
  end
end
