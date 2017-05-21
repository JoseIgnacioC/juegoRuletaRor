class RenamePlayersRoundsToPlayerRounds < ActiveRecord::Migration[5.1]
  def change
  	rename_table :players_rounds ,:player_rounds
  end
end
