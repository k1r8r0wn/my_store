class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/images/#{model.id}"
  end

  def cache_dir
    "uploads/tmp/"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
