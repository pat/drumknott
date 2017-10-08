# frozen_string_literal: true

class Drumknott::CLI
  EMPTY_CACHE  = {}.freeze
  HELP_MESSAGE = <<~MESSAGE
    Commands are:
      refresh: Update your site's content on Drumknott.
      keys:    Create local file with your Drumknott credentials.
      help:    Display this message.

    Example Usage:
      $ drumknott refresh
      $ drumknott keys my-site-name my-site-key

    Credentials for Drumknott are expected via environment variables, or
    via a .drumknott file created using the `keys` command.

      DRUMKNOTT_NAME: Your site name, as registered with Drumknott.
      DRUMKNOTT_KEY:  Your API key, as provided by Drumknott.
  MESSAGE

  def self.call(
    command, arguments = [], name = nil, key = nil, include_pages = nil
  )
    new(command, arguments, name, key, include_pages).call
  end

  def initialize(
    command, arguments = [], name = nil, key = nil, include_pages = nil
  )
    @command       = command
    @arguments     = arguments
    @name          = name
    @key           = key
    @include_pages = include_pages
  end

  def call
    case command
    when "refresh"
      Drumknott::Refresh.call name, key, include_pages?
    when "keys"
      Drumknott::Keys.call arguments
    else
      puts "Unknown command #{command}." unless command == "help"
      puts HELP_MESSAGE
    end
  end

  private

  attr_reader :command, :arguments

  def cache
    return EMPTY_CACHE unless File.exist? ".drumknott"

    @cache ||= JSON.parse File.read(".drumknott")
  end

  def name
    @name || cache["name"] || ENV["DRUMKNOTT_NAME"]
  end

  def key
    @key || cache["key"] || ENV["DRUMKNOTT_KEY"]
  end

  def include_pages?
    return @include_pages unless @include_pages.nil?
    return cache["pages"] unless cache["pages"].nil?

    Drumknott::IncludePages.call ENV["DRUMKNOTT_PAGES"]
  end
end
