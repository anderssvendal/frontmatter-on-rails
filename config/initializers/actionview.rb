# Uncomment if you're not on Rails 7,1, see https://www.shakacode.com/blog/rails-7-1-introduces-config-autoload_lib
# require 'strip_frontmatter_template_handler'

ActiveSupport.on_load(:action_view) do
  # Replace the registered template handlers for formats we want to support
  # Frontmatter
  [
    :erb,
    :slim
  ].each do |extension|
    handler = ActionView::Template.registered_template_handler(extension)

    ActionView::Template.register_template_handler(
      extension,
      StripFrontmatterTemplateHandler.new(handler)
    )
  end
end

