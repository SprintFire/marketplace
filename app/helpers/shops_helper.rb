module ShopsHelper
  def shop_header_image(s)
    s.header_image.url || "http://placehold.it/318x180"
  end
end
