source 'https://rubygems.org'

gemspec


gem 'coveralls', require: false, group: :development

cuke_modeler_major_version = 3

# rubocop:disable Bundler/DuplicatedGem
if RUBY_VERSION =~ /^2\.0/
  gem 'cucumber', '< 3.0.1' # Requires Ruby 2.1+ after this point
elsif RUBY_VERSION =~ /^2\.1/
  gem 'cucumber', '< 3.0.2' # Requires Ruby 2.2+ after this point
elsif [1, 2].include?(cuke_modeler_major_version)
  # Cucumber 4.x+ uses the `cucumber-gherkin` gem, which is incompatible with
  # the `gherkin` gem, upon which this version of the `cuke_modeler` gem depends
  gem 'cucumber', '< 4.0'
elsif [3].include?(cuke_modeler_major_version)
  # Cucumber <4.x+ uses the `gherkin` gem, which is incompatible with
  # the `cucumber-gherkin` gem, upon which this version of the `cuke_modeler` gem depends
  gem 'cucumber', '>= 4.0'
end
# rubocop:enable Bundler/DuplicatedGem

if RUBY_VERSION =~ /^2\.[0123]/
  gem 'simplecov-html', '< 0.11' # Requires Ruby 2.4+ after this point
end


gem 'cuke_modeler', "~> #{cuke_modeler_major_version}.0"
