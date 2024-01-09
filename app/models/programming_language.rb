class ProgrammingLanguage
  class << self
    def all
      # Find all the programming languages and sort them, newest first
      Dir.children(dirname)
         .filter { programming_language_template?(_1) }
         .map { dirname.join(_1) }
         .map { ProgrammingLanguage.new(_1) }
         .sort
         .reverse
    end

    def find(slug)
      all.find do |programming_language|
        programming_language.slug == slug
      end
    end

    def find!(slug)
      find(slug) || raise_record_not_found
    end

    private

    def dirname
      # Where all the templates are placed
      Rails.root.join('app/views/programming_languages')
    end

    def programming_language_template?(filename)
      # Do not treat templates for regular actions as programming languages
      [
        'index.',
        'show.',
        'edit.',
        'new.'
      ].none? do |reserved|
        filename.starts_with?(reserved)
      end
    end

    def raise_record_not_found
      raise ActiveRecord::RecordNotFound
    end
  end

  attr_accessor :pathname
  delegate :content, :data, to: :frontmatter, prefix: true

  def initialize(pathname)
    @pathname = pathname
  end

  def slug
    pathname.basename.to_s.split('.').first
  end

  def path
    "/#{slug}"
  end

  def name
    frontmatter_data['name']
  end

  def first_introduced
    frontmatter_data['first_introduced']
  end

  def <=>(other)
    # Can only be compare with other ProgrammingLanguage instances
    return nil unless other.is_a?(self.class)

    # Compare name if both languages was introduced the same year
    return name <=> other.name if first_introduced == other.first_introduced

    # Age before beauty
    first_introduced <=> other.first_introduced
  end

  private

  def frontmatter
    # Parse templates with RubyMatter
    @frontmatter ||= RubyMatter.read(pathname)
  end
end
