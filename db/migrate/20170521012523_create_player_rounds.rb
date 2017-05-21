class CreatePlayerRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :player_rounds do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
