require 'spec_helper'

RSpec.describe Drumknott::Keys do
  before :each do
    File.delete '.drumknott' if File.exists?('.drumknott')
  end

  after :each do
    File.delete '.drumknott' if File.exists?('.drumknott')
  end

  it 'writes a .drumknott file with the provided keys' do
    Drumknott::CLI.call 'keys', ['my-site', 'my-key']

    expect(File.exists?('.drumknott')).to eq(true)
    expect(File.read('.drumknott')).to eq(JSON.generate(
      'name' => 'my-site',
      'key'  => 'my-key'
    ))
  end
end
