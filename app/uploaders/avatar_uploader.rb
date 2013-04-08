# encoding: utf-8
require 'carrierwave/processing/mime_types'

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  
  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper
  
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
#    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
#修改如下代码，保存到一个新的路径
      'public/my/upload/directory'
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  #打开如下代码
   def extension_white_list
     %w(jpg jpeg gif png)
   end
   
  #添加如下代码
  CarrierWave::SanitizedFile.sanitize_regexp = /[^a-zA-Zа-яА-ЯёЁ0-9\.\-\+_]/u
  
  #Setting the content type
  include CarrierWave::MimeTypes
  process :set_content_type
  
  #Adding versions 
#  include CarrierWave::RMagick
#  process :resize_to_fit => [800, 800]
#  version :thumb do
#    process :resize_to_fill => [200,200]
#  end
  
#  version :animal do
#    version :human
#    version :monkey
#    version :llama
#  end
#   
#  version :human, :if => :is_human?
#  version :monkey, :if => :is_monkey?
#  version :banner, :if => :is_landscape?
#
#protected
#
#  def is_human? picture
#    model.can_program?(:ruby)
#  end
#
#  def is_monkey? picture
#    model.favorite_food == 'banana'
#  end
#
#  def is_landscape? picture
#    image = MiniMagick::Image.open(picture.path)
#    image[:width] > image[:height]
#  end 
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
