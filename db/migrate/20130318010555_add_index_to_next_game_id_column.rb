class AddIndexToNextGameIdColumn < ActiveRecord::Migration
  def change
    add_index :games, :next_game_id
  end
end
