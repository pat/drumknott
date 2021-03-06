# frozen_string_literal: true

class Drumknott::Outputs::Silent
  def self.call(&block)
    new(&block).call
  end

  def initialize(&block)
    @block = block
  end

  def call(_label, collection)
    collection.each { |item| block.call item }
  end

  private

  attr_reader :block
end
