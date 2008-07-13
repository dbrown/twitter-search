# Dan Croak, July 2008

require File.expand_path('lib/summize', File.dirname(__FILE__))
require 'rubygems'
require 'yaml'

namespace :yaml do
  desc "Write Summize results to yaml file so API is not hit every test."
  task :write do    
    write_yaml :tweets => 'Obama',                                     :file => 'obama'
    write_yaml :tweets => 'twitter search',                            :file => 'twitter_search'
    write_yaml :tweets => {:q => 'twitter search'},                    :file => 'twitter_search_and'
    write_yaml :tweets => {:q => '"happy hour"'},                      :file => 'happy_hour_exact'  
    write_yaml :tweets => {:q => 'obama OR hillary'},                  :file => 'obama_or_hillary'
    write_yaml :tweets => {:q => 'beer -root'},                        :file => 'beer_minus_root'
    write_yaml :tweets => {:q => '#haiku'},                            :file => 'hashtag_haiku'
    write_yaml :tweets => {:q => 'from:alexiskold'},                   :file => 'from_alexiskold'
    write_yaml :tweets => {:q => 'to:techcrunch'},                     :file => 'to_techcrunch'
    write_yaml :tweets => {:q => '@mashable'},                         :file => 'reference_mashable'
    write_yaml :tweets => {:q => '"happy hour" near:"san francisco"'}, :file => 'happy_hour_near_sf'
    write_yaml :tweets => {:q => 'superhero since:2008-05-01'},        :file => 'superhero since'
    write_yaml :tweets => {:q => 'ftw until:2008-05-03'},              :file => 'ftw_until'
    write_yaml :tweets => {:q => 'movie -scary :)'},                   :file => 'movie_positive_tude'
    write_yaml :tweets => {:q => 'flight :('},                         :file => 'flight_negative_tude'
    write_yaml :tweets => {:q => 'traffic ?'},                         :file => 'traffic_question'
    write_yaml :tweets => {:q => 'hilarious filter:links'},            :file => 'hilarious_links'
  end
end

def write_yaml(opts = {})
  @client = Summize::Client.new 'ruby-summize'
  tweets  = @client.query(opts[:tweets])
  File.open("#{File.join(File.dirname(__FILE__), 'test')}/#{opts[:file]}.yaml", 'w+') do |file| 
    file.puts tweets.to_yaml
  end
end
