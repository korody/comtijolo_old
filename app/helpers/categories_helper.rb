module CategoriesHelper
  def category_photo(slug)
    link_to image_tag("#{slug}.jpg", class: 'img-responsive'), casal_path
  end
end
