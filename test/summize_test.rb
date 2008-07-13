require File.join(File.dirname(__FILE__), 'test_helper')

class SummizeTest < Test::Unit::TestCase # :nodoc:

  context "@client.query 'Obama'" do
    setup do
      @tweets = read_yaml :file => 'obama'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing the single word "Obama"' do
      assert @tweets.all? { |tweet| tweet.text =~ /obama/i }
    end
  end
  
  context "@client.query 'twitter search'" do
    setup do
      @tweets = read_yaml :file => 'twitter_search'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing both "twitter" and "search"' do
      assert @tweets.all?{ |t| t.text =~ /twitter/i && t.text =~ /search/i }
    end
  end
  
  context "@client.query :q => 'twitter search'" do
    setup do
      @tweets = read_yaml :file => 'twitter_search_and'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing both "twitter" and "search"' do
      assert @tweets.all?{ |t| t.text =~ /twitter/i && t.text =~ /search/i }
    end
  end
  
  context '@client.query :q => \'"happy hour"\'' do
    setup do
      @tweets = read_yaml :file => 'happy_hour_exact'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing the exact phrase "happy hour"' do
      assert @tweets.all?{ |t| t.text =~ /happy hour/i }
    end
  end
  
  context "@client.query :q => 'obama OR hillary'" do
    setup do
      @tweets = read_yaml :file => 'obama_or_hillary'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing either "obama" or "hillary" (or both)' do
      assert @tweets.all?{ |t| t.text =~ /obama/i || t.text =~ /hillary/i }
    end
  end
  
  context "@client.query :q => 'beer -root'" do
    setup do
      @tweets = read_yaml :file => 'beer_minus_root'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing "beer" but not "root"' do
      assert @tweets.all?{ |t| t.text =~ /beer/i || t.text !~ /root/i }
    end
  end
  
  context "@client.query :q => '#haiku'" do
    setup do
      @tweets = read_yaml :file => 'hashtag_haiku'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing the hashtag "haiku"' do
      assert @tweets.all?{ |t| t.text =~ /#haiku/i }
    end
  end
  
  context "@client.query :q => 'from: alexiskold'" do
    setup do
      @tweets = read_yaml :file => 'from_alexiskold'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets sent from person "alexiskold"' do
      assert @tweets.all?{ |t| t.from_user == 'alexiskold' }
    end
  end
  
  context "@client.query :q => 'to:techcrunch'" do
    setup do
      @tweets = read_yaml :file => 'to_techcrunch'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets sent to person "techcrunch"' do
      assert @tweets.all?{ |t| t.text =~ /^@techcrunch/i }
    end
  end
  
  protected
  
    def read_yaml(opts = {})
      return if opts[:file].nil?
      YAML.load_file("#{File.dirname(__FILE__)}/#{opts[:file]}.yaml") 
    end
  
end
