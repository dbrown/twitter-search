require File.expand_path('../lib/summize', File.dirname(__FILE__))
require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'factory_girl'

class SummizeTest < Test::Unit::TestCase # :nodoc:

  context 'A basic Summize search' do
    setup do
      @client = Summize::Client.new 'politweets'
      @tweets = @client.query 'Obama'
      puts @tweets.inspect
    end

    should 'return tweets' do
      assert @tweets.any?
    end
    
    should 'have text for each tweet' do
      assert @tweets.all? { |tweet| !tweet.blank? }
    end
  end
  
end
