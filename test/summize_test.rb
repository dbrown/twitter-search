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
  
  context "@client.query :q => '@mashable'" do
    setup do
      @tweets = read_yaml :file => 'reference_mashable'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets referencing person "mashable"' do
      assert @tweets.all?{ |t| t.text =~ /@mashable/i }
    end
  end
  
  context "@client.query :q => '\"happy hour\" near:\"san francisco\"'" do
    setup do
      @tweets = read_yaml :file => 'happy_hour_near_sf'
    end
    
    # The Summize API makes you use the geocode parameter for location searching
    should 'not find tweets using the near operator' do
      assert ! @tweets.any?
    end
  end
  
  context "@client.query :q => 'near:NYC within:15mi'" do
    setup do
      @tweets = read_yaml :file => 'within_15mi_nyc'
    end
    
    # The Summize API makes you use the geocode parameter for location searching
    should 'not find tweets using the near operator' do
      assert ! @tweets.any?
    end
  end
  
  context "@client.query :q => 'superhero since:2008-05-01'" do
    setup do
      @tweets = read_yaml :file => 'superhero_since'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing "superhero" and sent since date "2008-05-01" (year-month-day)' do
      assert @tweets.all?{ |t| t.text =~ /superhero/i && convert_date(t.created_at) > DateTime.new(2008, 5, 1) }
    end
  end
  
  context "@client.query :q => 'ftw until:2008-05-03'" do
    setup do
      @tweets = read_yaml :file => 'ftw_until'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing "ftw" and sent up to date "2008-05-03"' do
      assert @tweets.all?{ |t| t.text =~ /ftw/i && convert_date(t.created_at) < DateTime.new(2008, 5, 3, 11, 59) }
    end
  end
  
  context "@client.query :q => 'movie -scary :)'" do
    setup do
      @tweets = read_yaml :file => 'movie_positive_tude'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing "movie", but not "scary", and with a positive attitude' do
      assert @tweets.all?{ |t| t.text =~ /movie/i && t.text !~ /scary/i && positive_attitude?(t.text) }
    end
  end
  
  context "@client.query :q => 'flight :('" do
    setup do
      @tweets = read_yaml :file => 'flight_negative_tude'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing "flight" and with a negative attitude' do
      assert @tweets.all?{ |t| t.text =~ /flight/i && negative_attitude?(t.text) }
    end
  end
  
  context "@client.query :q => 'traffic ?'" do
    setup do
      @tweets = read_yaml :file => 'traffic_question'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing "traffic" and asking a question' do
      assert @tweets.all?{ |t| t.text =~ /traffic/i && t.text.include?('?') }
    end
  end
  
  context "@client.query :q => 'hilarious filter:links'" do
    setup do
      @tweets = read_yaml :file => 'hilarious_links'
    end
    
    should_have_default_search_behaviors
    
    should 'find tweets containing "hilarious" and linking to URLs' do
      assert @tweets.all?{ |t| t.text =~ /hilarious/i && hyperlinks?(t.text) }
    end
  end
  
  # TODO: pagination
  
  protected
  
    def convert_date(date)
      date = date.split(' ')
      DateTime.new(date[3].to_i, convert_month(date[2]), date[1].to_i)
    end
  
    def convert_month(str)
      months = { 'Jan' => 1, 'Feb' => 2, 'Mar' => 3, 'Apr' => 4,
                 'May' => 5, 'Jun' => 6, 'Jul' => 7, 'Aug' => 8,
                 'Sep' => 9, 'Oct' => 10, 'Nov' => 11, 'Dec' => 12 }
      months[str]
    end
  
    def positive_attitude?(str)
      str.include?(':)') || str.include?('=)') || str.include?(':-)') || str.include?(':D')
    end
    
    def negative_attitude?(str)
      str.include?(':(') || str.include?('=(') || str.include?(':-(') || str.include?(':P')
    end
    
    def hyperlinks?(str)
      str.include?('http://') || str.include?('https://')
    end
  
    def read_yaml(opts = {})
      return if opts[:file].nil?
      YAML.load_file File.join(File.dirname(__FILE__), 'yaml', "#{opts[:file]}.yaml") 
    end
  
end
