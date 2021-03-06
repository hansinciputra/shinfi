# config/initializers/carrierwave.rb
# This file is not created by default so you might have to create it yourself.

CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/"
  config.storage = :fog
  config.permissions = 0666
  
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],            # required
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],     # required
    :region                 => 'ap-southeast-1'                        # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'shinfithecraft-product-image'               # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end