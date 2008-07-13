require File.expand_path('../lib/summize', File.dirname(__FILE__))
require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'yaml'

class Test::Unit::TestCase
  
  def self.should_find_tweets
    should 'find tweets' do
      assert @tweets.any?
    end
  end
  
  def self.should_have_text_for_all_tweets
    should 'have text for all tweets' do
      assert @tweets.all? { |tweet| tweet.text.size > 0 }
    end
  end
  
end