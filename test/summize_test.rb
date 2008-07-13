require File.join(File.dirname(__FILE__), 'test_helper')

class SummizeTest < Test::Unit::TestCase # :nodoc:

  context "@client.query 'Obama'" do
    setup do
      @tweets = read_yaml :file => 'obama'
    end
    
    should_find_tweets
    should_have_text_for_all_tweets
    should_return_page 1
    should_return_tweets_in_sets_of 15
    
    should 'have text containing the word "Obama"' do
      assert @tweets.all? { |tweet| tweet.text =~ /obama/i }
    end
  end
  
  context "@client.query 'twitter search'" do
    setup do
      @tweets = read_yaml :file => 'twitter_search'
    end
    
    should_find_tweets
    should_have_text_for_all_tweets
    should_return_page 1
    should_return_tweets_in_sets_of 15
    
    should 'have text containing the word "twitter" and the word "search"' do
      assert @tweets.all? { |tweet| 
        tweet.text =~ /twitter/i && tweet.text =~ /search/i
      }
    end
  end
  
  protected
  
    def read_yaml(opts = {})
      return if opts[:file].nil?
      YAML.load_file("#{File.dirname(__FILE__)}/#{opts[:file]}.yaml") 
    end
  
end
