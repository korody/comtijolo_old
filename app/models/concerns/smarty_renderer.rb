class SmartyRenderer < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Context

  DEFAULT_OPTIONS = {
    hard_wrap: true,
    safe_links_only: true,
    link_attributes: {
      target: '_blank'
    }
  }

  def initialize(options = {})
    super options.reverse_merge!(DEFAULT_OPTIONS)
  end
end