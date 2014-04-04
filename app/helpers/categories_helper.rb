module CategoriesHelper
  def category_photo(name)
    link_to image_tag("#{name.parameterize}.jpg", class: 'img-responsive'), casal_path
  end
end
