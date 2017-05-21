class CreateForecasts < ActiveRecord::Migration[5.1]
  def change
    create_table :forecasts do |t|
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
