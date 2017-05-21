class AddPlayerToPlayerRounds < ActiveRecord::Migration[5.1]
  def change
    add_reference :player_rounds, :player, foreign_key: true
  end
end
