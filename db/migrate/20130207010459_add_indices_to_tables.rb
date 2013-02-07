class AddIndicesToTables < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.index :score
    end

    change_table :brackets do |t|
      t.index :user_id
    end

    change_table :games do |t|
      t.index :bracket_id
    end
  end
end
