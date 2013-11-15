module ApplicationHelper
  def page_title(title)
    base_title = "comtijolo"
    title.empty? ? base_title : "#{base_title} / #{title}"
  end

  def icon_tag(icon, css_class = nil)
    "<span class='glyphicon glyphicon-#{icon} #{css_class}'></i>".html_safe
  end

  # def nested_page_path(post)
  #   "/" + (post.ancestors + [post]).map(&:to_param).join("/")
  # end
end