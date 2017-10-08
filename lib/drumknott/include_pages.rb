# frozen_string_literal: true

class Drumknott::IncludePages
  TRUE_OPTIONS = %w[ true yes y ].freeze

  def self.call(value)
    case value
    when TrueClass, FalseClass
      value
    else
      value.nil? || TRUE_OPTIONS.include?(value.downcase)
    end
  end
end
