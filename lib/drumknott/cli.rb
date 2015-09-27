class Drumknott::CLI
  def self.call(command, name = nil, key = nil)
    new(command, name, key).call
  end

  def initialize(command, name = nil, key = nil)
    @command, @name, @key = command, name, key
  end

  def call
    case command
    when 'refresh'
      Drumknott::Refresh.call name, key
    else
      puts "Unknown command #{command}." unless command == 'help'
      puts <<-MESSAGE
Commands are:
  refresh: Update your site's content on Drumknott.
  help:    Display this message.

Example Usage:
  $ drumknott refresh

Credentials for Drumknott are expected via environment variables:
  DRUMKNOTT_NAME: Your site name, as registered with Drumknott.
  DRUMKNOTT_KEY:  Your API key, as provided by Drumknott.
      MESSAGE
    end
  end

  private

  attr_reader :command

  def name
    @name || ENV['DRUMKNOTT_NAME']
  end

  def key
    @key || ENV['DRUMKNOTT_KEY']
  end
end
