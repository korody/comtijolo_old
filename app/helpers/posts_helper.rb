module PostsHelper
  def markdown(text)
    parsed_text = Markdown.new(text, SmartyRenderer.new).to_html
    raw parsed_text
  end

  def mtd(detail)
    "<td>#{markdown(detail)}</td>".html_safe
  end
end