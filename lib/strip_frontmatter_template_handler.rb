class StripFrontmatterTemplateHandler
  attr_reader :handler

  def initialize(handler)
    @handler = handler
  end

  def call(template, source)
    # Extract the non-frontmatter part of the template
    source = RubyMatter.parse(source).content

    # Pass the extracted source to the original handler
    handler.call(template, source)
  end
end

