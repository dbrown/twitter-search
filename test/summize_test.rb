require File.expand_path('../lib/summize', File.dirname(__FILE__))
require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'factory_girl'
require 'yaml'

class SummizeTest < Test::Unit::TestCase # :nodoc:

  context 'A Summize search' do
    context 'for Obama' do
      setup do
        @tweets = read_yaml :file => 'obama'
      end

      should 'return tweets' do
        assert @tweets.any?
      end

      should 'have text for each tweet' do
        assert @tweets.all? { |tweet| !tweet.blank? }
      end
      
      should 'return page one' do
        assert_equal 1, @tweets.page
      end
      
      should 'return 15 results per page' do
        assert_equal 15, @tweets.results_per_page
      end
    end
  end
  
  protected
  
    def read_yaml(opts = {})
      return if opts[:file].nil?
      YAML.load_file("#{File.dirname(__FILE__)}/#{opts[:file]}.yaml") 
    end
  
end
