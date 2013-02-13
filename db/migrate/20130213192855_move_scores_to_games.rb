class MoveScoresToGames < ActiveRecord::Migration
  def change
    add_column :games, :score, :integer, :default => 0
    remove_column :users, :score
  end
end