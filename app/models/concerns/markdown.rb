class Markdown
  DEFAULT_OPTIONS = {
    autolink: true,
    fenced_code_blocks: true,
    no_images: true,
    no_intra_emphasis: true,
    strikethrough: true
  }

  def initialize(text, renderer, options = {})
    @text = text
    @renderer = renderer
    @options = options.reverse_merge!(DEFAULT_OPTIONS)
  end

  def to_html
    Redcarpet::Markdown.new(@renderer, @options).render(@text)
  end
end