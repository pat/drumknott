# frozen_string_literal: true

class Drumknott::Outputs::ProgressBar < Drumknott::Outputs::Silent
  def call(label, collection)
    bar = ::ProgressBar.create :title => label, :total => collection.length

    collection.each do |item|
      block.call item
      bar.increment
    end
  end
end
