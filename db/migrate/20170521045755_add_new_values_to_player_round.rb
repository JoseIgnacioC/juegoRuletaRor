class AddNewValuesToPlayerRound < ActiveRecord::Migration[5.1]
  def change
    add_column :player_rounds, :betValue, :string
  end
end
