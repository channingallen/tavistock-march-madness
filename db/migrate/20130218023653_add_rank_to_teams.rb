class AddRankToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :rank, :integer, :null => false
  end
end