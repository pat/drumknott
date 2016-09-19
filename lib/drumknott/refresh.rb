class Drumknott::Refresh
  URL = 'https://drumknottsearch.com'

  def self.call(name, key, include_pages = true)
    new(name, key, include_pages).call
  end

  def initialize(name, key, include_pages)
    @name, @key, @include_pages = name, key, include_pages
  end

  def call
    site.process

    clear
    update
  end

  private

  attr_reader :name, :key

  def clear
    connection.post do |request|
      request.url "/api/v1/#{name}/pages/clear"
      request.headers['AUTHENTICATION'] = key
    end
  end

  def connection
    @connection ||= Faraday.new(:url => URL) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def include_pages?
    @include_pages
  end

  def output
    @output ||= output_class.new { |document| update_document document }
  end

  def output_class
    return Drumknott::Outputs::Silent if ENV['DRUMKNOTT_SILENT']

    require 'ruby-progressbar'
    Drumknott::Outputs::ProgressBar
  rescue LoadError
    Drumknott::Outputs::Silent
  end

  def site
    @site ||= Jekyll::Site.new Jekyll.configuration
  end

  def update
    output.call "Posts", site.posts.docs
    output.call "Pages", site.pages if include_pages?
  end

  def update_document(document)
    connection.put do |request|
      request.url "/api/v1/#{name}/pages"

      request.headers['AUTHENTICATION'] = key
      request.headers['Content-Type']   = 'application/json'

      request.body = JSON.generate({
        :page => {
          :name    => document.data['title'],
          :path    => document.url,
          :content => document.output
        }
      })
    end
  end
end
