class Forecast < ApplicationRecord

	def get_weather_data
		ForecastIO.forecast(lat,lng)
	end
end
