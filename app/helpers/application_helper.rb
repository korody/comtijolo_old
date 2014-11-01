module ApplicationHelper
  def icon_tag(icon, options = {})
    options[:class] = (%w[fa] | icon.split).join(" fa-")
    content_tag :i, nil, options
  end
end