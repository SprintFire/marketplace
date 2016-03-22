module ShopsHelper
  def shop_header_image(s)
    s.header_image.url || "/assets/placeholder_318x180.png"
  end
end
