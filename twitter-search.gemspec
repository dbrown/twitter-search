Gem::Specification.new do |s|
  s.name = %q{twitter-search}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dustin Sallings", "Dan Croak"]
  s.date = %q{2008-10-17}
  s.description = %q{Ruby client for Twitter Search.}
  s.email = %q{dcroak@thoughtbot.com}
  s.files = ["Rakefile", "README.markdown", "TODO.markdown", "VERSION.yml", "lib/twitter_search.rb", "test/test_helper.rb", "test/twitter_search_test.rb", "test/yaml", "test/yaml/arabic.yaml", "test/yaml/beer_minus_root.yaml", "test/yaml/english.yaml", "test/yaml/flight_negative_tude.yaml", "test/yaml/from_alexiskold.yaml", "test/yaml/ftw_until.yaml", "test/yaml/happy_hour_exact.yaml", "test/yaml/happy_hour_near_sf.yaml", "test/yaml/hashtag_haiku.yaml", "test/yaml/hilarious_links.yaml", "test/yaml/movie_positive_tude.yaml", "test/yaml/obama.yaml", "test/yaml/obama_or_hillary.yaml", "test/yaml/reference_mashable.yaml", "test/yaml/results_per_page.yaml", "test/yaml/superhero_since.yaml", "test/yaml/to_techcrunch.yaml", "test/yaml/traffic_question.yaml", "test/yaml/twitter_search.yaml", "test/yaml/twitter_search_and.yaml", "test/yaml/within_15mi_nyc.yaml"]
  s.homepage = %q{http://github.com/dancroak/twitter-search}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Ruby client for Twitter Search.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<json>, [">= 1.1.2"])
    else
      s.add_dependency(%q<json>, [">= 1.1.2"])
    end
  else
    s.add_dependency(%q<json>, [">= 1.1.2"])
  end
end
