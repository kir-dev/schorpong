module ImageHelper
  def image?
    image.attached?
  end

  def thumb
    image.variant(resize: "700x500!")
  end

  def square_thumb
    image.variant(resize: "500x500!")
  end
end
