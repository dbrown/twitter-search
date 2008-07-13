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
  
  context "@client.query :q => '@mashable" do
    setup do
      @tweets = read_yaml :file => 'reference_mashable'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets referencing person "mashable"' do
      assert @tweets.all?{ |t| t.text =~ /@mashable/i }
    end
  end
  
  # TODO: :q => '"happy hour" <b>near:</b>"san francisco"' containing the exact phrase "happy hour" and sent near "san francisco"
  # TODO: :q => '<b>near:</b>NYC <b>within:</b>15mi</a>'</td><td>sent within 15 miles of "NYC"
  # TODO: :q => 'superhero <b>since:</b>2008-05-01'</a></td><td>containing "superhero" and sent since date "2008-05-01" (year-month-day)
  # TODO: :q => 'ftw <b>until:</b>2008-05-03'</a></td><td>containing "ftw" and sent up to date "2008-05-03"
  # TODO: :q => 'movie -scary <b>:)</b>'</a></td><td>containing "movie", but not "scary", and with a positive attitude
  # TODO: :q => 'flight <b>:(</b>'</a></td><td>containing "flight" and with a negative attitude.
  # TODO: :q => 'traffic <b>?</b>'</a></td><td>containing "traffic" and asking a question
  # TODO: :q => 'hilarious <b>filter:links</b>'</a></td><td>containing "hilarious" and linking to URLs
  
  # TODO: pagination
  
  protected
  
    def read_yaml(opts = {})
      return if opts[:file].nil?
      YAML.load_file("#{File.dirname(__FILE__)}/#{opts[:file]}.yaml") 
    end
  
end
