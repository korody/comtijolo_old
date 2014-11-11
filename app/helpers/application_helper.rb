module ApplicationHelper
  def tag_link(title, options = {})
    current_link = options.delete(:current_link)
    options[:class] = (current_link == params[:tag]) ? 'active' : nil
    content_tag :li, options do
      link_to title, {controller: controller_name, action: :show, tag: current_link }, title: "etiqueta #{title}"
    end
  end

  def category_nav(category)
    content_tag :li do
      link_to ".", category_path(category), id: category, title: "categoria #{category}"
    end
  end
  
  def icon_tag(icon, options = {})
    options[:class] = (%w[fa] | icon.split).join(" fa-")
    content_tag :i, nil, options
  end

  def pagination_for(collection)
    will_paginate collection, class: 'pagination', renderer: BootstrapPagination::Rails
  end
end