Rails.application.configure do
 
end

require "stripe"
Stripe.api_key = ""

ENV['EMBER_ENV'] = 'production'
ENV['REDIS_URL'] = 'redis://127.0.0.1:6379/15'

ENV['BUGSNAG_API_KEY'] = 

ENV['FACEBOOK_KEY'] = 
ENV['FACEBOOK_SECRET'] = 

ENV['EFW_BASE_API_URL'] =
ENV['EFW_BASE_APP_URL'] = 
ENV['EFW_BASE_FLEX_URL'] = 
