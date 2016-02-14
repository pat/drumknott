class Drumknott::IncludePages
  TRUE_OPTIONS = ['true', 'yes', 'y'].freeze

  def self.call(value)
    value.nil? || TRUE_OPTIONS.include?(value.downcase)
  end
end
