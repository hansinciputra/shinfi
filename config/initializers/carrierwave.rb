# config/initializers/carrierwave.rb
# This file is not created by default so you might have to create it yourself.

CarrierWave.configure do |config|

  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => '',            # required
    :aws_secret_access_key  => '',     # required
    :region                 => 'ap-southeast-1'                        # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'shinfithecraft-product-image'               # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end