module ApplicationHelper
  def page_title(title)
    base_title = "comtijolo"
    title.empty? ? base_title : "#{base_title} / #{title}"
  end

  def icon_tag(icon, css_class = nil)
    "<i class='icon-#{icon} #{css_class}'></i>".html_safe
  end
end