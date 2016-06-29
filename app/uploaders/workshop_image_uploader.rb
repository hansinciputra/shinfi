# encoding: utf-8

class WorkshopImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
 include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :fog
  storage :file

  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


   version :standard do
     process :resize_to_limit => [510, 430]
   end
   version :thumb do
     process :resize_to_limit => [250, 250]
   end
   version :feed, from_version: :standard do
     process :resize_to_limit => [250, 120]
   end
   version :medium_thumb, from_version: :thumb do
     process :resize_to_limit => [100,100]
   end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end

