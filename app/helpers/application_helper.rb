module ApplicationHelper
  # def page_title(title)
  #   base_title = "comTijolo"
  #   title.empty? ? base_title : "#{base_title} | #{title}"
  # end

  def icon_tag(icon, css_class = nil)
    "<span class='glyphicon glyphicon-#{icon} #{css_class}'></span>".html_safe
  end

end