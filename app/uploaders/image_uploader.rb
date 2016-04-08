class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

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

  version :normal do
    process resize_to_fill: [400, 400]
  end

  version :thumb, from_version: :normal do
    process resize_to_fill: [100, 100]
  end
end
