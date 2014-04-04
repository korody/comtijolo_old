module ApplicationHelper
  def icon_tag(icon, css_class = nil)
    "<span class='glyphicon glyphicon-#{icon} #{css_class}'></span>".html_safe
  end
end