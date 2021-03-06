class SubPosterUploader < PosterUploader

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  version :standard do
     process :resize_to_limit => [320, 320]
  end
  version :display do
     process :resize_to_limit => [500, 250]
  end
end