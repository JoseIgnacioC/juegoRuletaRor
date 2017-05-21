json.extract! forecast, :id, :lat, :lng, :created_at, :updated_at
json.url forecast_url(forecast, format: :json)
