# frozen_string_literal: true

require "spec_helper"

RSpec.describe Drumknott::Keys do
  before :each do
    File.delete ".drumknott" if File.exist?(".drumknott")
  end

  after :each do
    File.delete ".drumknott" if File.exist?(".drumknott")
  end

  it "writes a .drumknott file with the provided keys" do
    Drumknott::CLI.call "keys", %w[ my-site my-key yes ]

    expect(File.exist?(".drumknott")).to eq(true)
    expect(File.read(".drumknott")).to eq(
      JSON.generate(
        "name"  => "my-site",
        "key"   => "my-key",
        "pages" => true
      )
    )
  end
end
