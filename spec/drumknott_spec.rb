require 'spec_helper'

RSpec.describe Drumknott do
  let(:drumknott) { Drumknott.new 'my-site', 'my-key' }
  let(:site)      { double 'Site', :process => true, :posts => [post, post] }
  let(:post)      { double 'Post', :title => 'A post', :url => '/',
    :output => 'post content' }

  before :each do
    allow(Jekyll).to receive(:configuration).and_return(double)

    stub_const 'Jekyll::Site', double(:new => site)

    stub_request(
      :post, "http://drumknottsearch.com/api/v1/my-site/pages/clear"
    ).to_return :status => 200

    stub_request(
      :put, "http://drumknottsearch.com/api/v1/my-site/pages"
    ).to_return :status => 200
  end

  describe '#refresh' do
    it 'processes the site to load all data' do
      expect(site).to receive(:process)

      drumknott.refresh
    end

    it 'clears out the existing data' do
      drumknott.refresh

      expect(
        a_request(
          :post, "http://drumknottsearch.com/api/v1/my-site/pages/clear"
        ).with(:headers => {'AUTHENTICATION' => 'my-key'})
      ).to have_been_made
    end

    it 'updates each post' do
      drumknott.refresh

      expect(
        a_request(
          :put, "http://drumknottsearch.com/api/v1/my-site/pages"
        ).with(
          :body => {"page" => {
            "name"    => "A post",
            "path"    => "/",
            "content" => "post content"
          }}.to_json,
          :headers => {'AUTHENTICATION' => 'my-key'}
        )
      ).to have_been_made.twice
    end
  end
end
