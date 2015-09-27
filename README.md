# Drumknott CLI

Command line tool for the Drumknott search service. When invoked, it takes each of your compiled Jekyll pages and uploads them to Drumknott.

## Installation

    $ gem install drumknott

## Usage

From within the local Jekyll site directory, using the credentials provided by Drumknott:

    $ drumknott keys SITE_NAME SITE_KEY
    $ drumknott refresh

The `keys` command will save your credentials to a `.drumknott` file in your site's directory. Do not commit this file to git! If you don't want to have that file saved, you can alternatively use the environment variables `DRUMKNOTT_NAME` and `DRUMKNOTT_KEY` respectively.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Firstly, please note the Code of Conduct for all contributions to this project. If you accept that, then the steps for contributing are probably something along the lines of:

1. Fork it ( https://github.com/pat/drumknott/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Licence

Copyright (c) 2015, Drumknott is developed and maintained by Pat Allan, and is
released under the open MIT Licence.
