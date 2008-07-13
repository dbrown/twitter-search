# A simple Summize client for Ruby.

## Example

    require 'summize'

	  client = Summize::Client.new 'my-user-argent'
    tweets = client.query :q => 'search query'
    tweets.each { |tweet| puts tweet.text }
