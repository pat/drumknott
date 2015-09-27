class Drumknott::Keys
  def self.call(arguments)
    new(arguments).call
  end

  def initialize(arguments)
    @name, @key, ignored = *arguments
  end

  def call
    File.write '.drumknott', JSON.generate(
      'name' => name,
      'key'  => key
    )
  end

  private

  attr_reader :name, :key
end
