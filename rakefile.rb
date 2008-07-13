# Dan Croak, July 2008

require File.expand_path('lib/summize', File.dirname(__FILE__))
require 'rubygems'
require 'yaml'

namespace :yaml do
  desc "Write Summize results to yaml file so API is not hit every test."
  task :write do
    
    @client = Summize::Client.new 'ruby-summize'
    
    write_yaml :tweets => @client.query('Obama'), :file => 'obama'
  end
end

def write_yaml(opts = {})
  return if opts[:tweets].nil? || opts[:file].nil?
  File.open("#{File.join(File.dirname(__FILE__), 'test')}/#{opts[:file]}.yaml", 'w+') do |file| 
    file.puts opts[:tweets].to_yaml
  end
end
