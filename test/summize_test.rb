require File.join File.dirname(__FILE__), 'test_helper'

class SummizeTest < Test::Unit::TestCase # :nodoc:

  context "@client.query('Obama')" do
    setup do
      @tweets = read_yaml :file => 'obama'
    end
    
    should_find_tweets
    should_have_text_for_all_tweets
    
    should 'return page one' do
      assert_equal 1, @tweets.page
    end
    
    should 'return 15 results per page' do
      assert_equal 15, @tweets.results_per_page
    end
    
    should 'have text containing the word "Obama"' do
      assert @tweets.all? { |tweet| tweet.text.include? 'Obama' }
    end
  end
  
  protected
  
    def read_yaml(opts = {})
      return if opts[:file].nil?
      YAML.load_file("#{File.dirname(__FILE__)}/#{opts[:file]}.yaml") 
    end
  
end
