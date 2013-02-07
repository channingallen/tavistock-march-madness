class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :bracket_id
      t.integer :team_one_id
      t.integer :team_two_id
      t.integer :winning_team_id
      t.integer :next_game_id

      t.timestamps
    end
  end
end
