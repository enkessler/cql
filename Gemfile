source "http://rubygems.org"

gemspec


if RUBY_VERSION =~ /^1\.8/
  gem 'cucumber', '<1.3.0'
  gem 'gherkin', '<2.12.0'
elsif RUBY_VERSION =~ /^1\./
  gem 'cucumber', '<2.0.0'
end


gem 'coveralls', :require => false, :group => :development