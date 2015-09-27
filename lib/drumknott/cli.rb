class Drumknott::CLI
  def self.call(command, arguments = [], name = nil, key = nil)
    new(command, arguments, name, key).call
  end

  def initialize(command, arguments = [], name = nil, key = nil)
    @command, @arguments, @name, @key = command, arguments, name, key
  end

  def call
    case command
    when 'refresh'
      Drumknott::Refresh.call name, key
    when 'keys'
      Drumknott::Keys.call arguments
    else
      puts "Unknown command #{command}." unless command == 'help'
      puts <<-MESSAGE
Commands are:
  refresh: Update your site's content on Drumknott.
  keys:    Create local file with your Drumknott credentials.
  help:    Display this message.

Example Usage:
  $ drumknott refresh
  $ drumknott keys my-site-name my-site-key

Credentials for Drumknott are expected via environment variables, or via a
.drumknott file created using the `keys` command.

  DRUMKNOTT_NAME: Your site name, as registered with Drumknott.
  DRUMKNOTT_KEY:  Your API key, as provided by Drumknott.
      MESSAGE
    end
  end

  private

  attr_reader :command, :arguments

  def name
    @name || ENV['DRUMKNOTT_NAME']
  end

  def key
    @key || ENV['DRUMKNOTT_KEY']
  end
end
