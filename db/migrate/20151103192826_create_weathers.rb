class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.datetime :time
      t.float :indoor_temp
      t.float :outdoor_temp
      t.float :dewpoint
      t.float :wind_speed
      t.float :relative_rain
      t.string :wind_direction
      t.float :indoor_humidity
      t.float :outdoor_humidity
      t.float :relative_pressure
      t.float :wind_chill
      t.float :gust_speed
      t.float :total_rain

      t.timestamps null: false
    end
  end
end
