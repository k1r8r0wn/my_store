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
    process :crop!
    process resize_to_fill: [400, 400]
  end

  version :thumb, from_version: :normal do
    process resize_to_fill: [100, 100]
  end

  def crop!
    return unless model.image_crop_data
    manipulate! do |img|
      x = model.image_crop_data[:x]
      y = model.image_crop_data[:y]
      w = model.image_crop_data[:width]
      h = model.image_crop_data[:height]
      img.crop "#{w}x#{h}+#{x}+#{y}"
    end
  end

end

