require 'rubygems'
require 'net/http'
require 'json'
require 'cgi'

module TwitterSearch

  class Tweet
    VARS = [:text, :from_user, :to_user, :to_user_id, :id, :iso_language_code, :from_user_id, :created_at, :profile_image_url ]
    attr_reader *VARS
    attr_reader :language
    
    def initialize(h)
      @language = h['iso_language_code']
      VARS.each { |v| instance_variable_set "@#{v}", h[v.to_s] }
    end
  end

  class Tweets
    VARS = [:since_id, :max_id, :results_per_page, :page, :query, :next_page]
    attr_reader *VARS

    include Enumerable

    def initialize(h)
      @results = h['results'].map { |tweet| Tweet.new tweet }
      VARS.each { |v| instance_variable_set "@#{v}", h[v.to_s] }
    end

    def each(&block)
      @results.each(&block)
    end

    def size
      @results.size
    end
    
    def [](index)
      @results[index]
    end
  end

  class Client
    def initialize(agent = 'twitter-search')
      @agent = agent
    end

    def query(opts = {})
      url = URI.parse 'http://search.twitter.com/search.json'
      url.query = sanitize_query opts
      Tweets.new JSON.parse(Net::HTTP.get(url))
    end

    private

      def sanitize_query(opts)
        if opts.is_a? String
          "q=#{CGI.escape(opts)}" 
        elsif opts.is_a? Hash
          "#{sanitize_query_hash(opts)}"
        end
      end

      def sanitize_query_hash(query_hash)
        query_hash.map{ |k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
      end
  end

end
