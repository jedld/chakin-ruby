# Chakin-rb

A port of the python chakin library that downloads pre-trained word vectors without much fuss.

This gem is a port of https://github.com/chakki-works/chakin

Which makes selecting and downloading pre trained word vectors super easy

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chakin-rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chakin-ruby

## Usage

Get a list of available datasets

```ruby
require "chakin-rb/chakin"

Chakin::Vectors.search('English')
=>
#<Daru::DataFrame(12x7)>
                  Name  Dimension     Corpus Vocabulary     Method   Language     Author
          2 fastText(e        300  Wikipedia       2.5M   fastText    English   Facebook
         11 GloVe.6B.5         50 Wikipedia+       400K      GloVe    English   Stanford
         12 GloVe.6B.1        100 Wikipedia+       400K      GloVe    English   Stanford
         13 GloVe.6B.2        200 Wikipedia+       400K      GloVe    English   Stanford
         14 GloVe.6B.3        300 Wikipedia+       400K      GloVe    English   Stanford
         15 GloVe.42B.        300 Common Cra       1.9M      GloVe    English   Stanford
         16 GloVe.840B        300 Common Cra       2.2M      GloVe    English   Stanford
         17 GloVe.Twit         25 Twitter(27       1.2M      GloVe    English   Stanford
         18 GloVe.Twit         50 Twitter(27       1.2M      GloVe    English   Stanford
         19 GloVe.Twit        100 Twitter(27       1.2M      GloVe    English   Stanford
         20 GloVe.Twit        200 Twitter(27       1.2M      GloVe    English   Stanford
         21 word2vec.G        300 Google New       3.0M   word2vec    English     Google
```

Download a dataset locally

```ruby
require "chakin-rb/chakin"

Chakin::Vectors.download(number: 2, save_dir: './') # select fastText(en)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/chakin-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Chakin::Ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/chakin-ruby/blob/master/CODE_OF_CONDUCT.md).
