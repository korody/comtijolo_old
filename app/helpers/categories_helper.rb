module CategoriesHelper
  def category_photo(name)
    case name
    when "Ô lá em casa!"
    when "um quarto sobre dois"
    end
    link_to image_tag("#{name.parameterize}.jpg", class: 'img-responsive'), casal_path
  end
end
