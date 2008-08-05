Gem::Specification.new do |s|
  s.name             = "twitter-search"
  s.version          = "0.5"
  s.date             = "2008-08-04"
  s.summary          = "Ruby client for Twitter Search."
  s.email            = "dcroak@thoughtbot.com"
  s.homepage         = "http://github.com/dancroak/twitter-search"
  s.description      = "A Ruby client for the conversational search engine."
  s.has_rdoc         = true
  s.authors          = ["Dustin Sallings", "Dan Croak"]
  s.files            = ["README.markdown", "twitter-search.gemspec", "lib/twitter_search.rb"]
  s.rdoc_options     = ["--main", "README.markdown"]
  s.extra_rdoc_files = ["README.markdown"]
  s.add_dependency('json', '>= 1.1.2')
end
