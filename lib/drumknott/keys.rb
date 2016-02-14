class Drumknott::Keys
  def self.call(arguments)
    new(arguments).call
  end

  def initialize(arguments)
    @name, @key, @pages, ignored = *arguments
  end

  def call
    File.write '.drumknott', JSON.generate(
      'name'  => name,
      'key'   => key,
      'pages' => Drumknott::IncludePages.call(pages)
    )
  end

  private

  attr_reader :name, :key, :pages
end
