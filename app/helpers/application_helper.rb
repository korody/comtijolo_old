module ApplicationHelper
  def collection_link(title, path, options = {})
    current_link = options.delete(:current_link)
    options[:class] = (current_link == params[:collection]) ? 'active' : nil
    content_tag :li, options do
      link_to title, path, title: "série #{title}"
    end
  end

  def icon_tag(icon, options = {})
    options[:class] = (%w[fa] | icon.split).join(" fa-")
    content_tag :i, nil, options
  end
end