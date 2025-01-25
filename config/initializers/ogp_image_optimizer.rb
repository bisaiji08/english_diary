require 'mini_magick'

image_path = Rails.root.join('app/assets/images/ogp-image.jpg')
output_path = Rails.root.join('app/assets/images/ogp-image-optimized.jpg')

unless File.exist?(output_path)
  image = MiniMagick::Image.open(image_path)
  image.resize "1200x630"
  image.write(output_path)
  Rails.logger.info "OGP image resized and saved to #{output_path}"
end
