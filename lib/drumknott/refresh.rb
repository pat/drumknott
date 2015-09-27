class Drumknott::Refresh
  URL = 'http://drumknottsearch.com'

  def self.call(name, key)
    new(name, key).call
  end

  def initialize(name, key)
    @name, @key = name, key
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

  def site
    @site ||= Jekyll::Site.new Jekyll.configuration
  end

  def update
    site.posts.each do |page|
      connection.put do |request|
        request.url "/api/v1/#{name}/pages"

        request.headers['AUTHENTICATION'] = key
        request.headers['Content-Type']   = 'application/json'

        request.body = JSON.generate({
          :page => {
            :name    => page.title,
            :path    => page.url,
            :content => page.output
          }
        })
      end
    end
  end
end
