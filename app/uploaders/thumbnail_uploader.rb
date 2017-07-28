class ThumbnailUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # 保存形式をJPGにする
  process convert: 'png'

  # サムネイルを生成する設定
  version :thumb do
    process resize_to_fit: [100, 100]
  end

  version :medium do
    process resize_to_fit: [300, 300]
  end

  storage :fog

  def filename
    "#{secure_token}.png" if original_filename.present?
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  private

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
