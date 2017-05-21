class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.integer :number
      t.datetime :dateTime
      t.boolean :conservative
      t.string :result

      t.timestamps
    end
  end
end
