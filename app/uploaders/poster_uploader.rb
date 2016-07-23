# encoding: utf-8

class PosterUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
 include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  include CarrierWave::MimeTypes
  process :set_content_type
end

