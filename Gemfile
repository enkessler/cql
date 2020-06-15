source "http://rubygems.org"

gemspec

# cql can play with pretty much any version of these but they all play differently with Ruby
if RUBY_VERSION =~ /^1\.8/
  gem 'cucumber', '< 1.3.0'
  gem 'gherkin', '< 2.12.0'
  gem 'rainbow', '< 2.0' # Ruby 1.8.x support dropped after this version
  gem 'rake', '< 11.0' # Rake dropped 1.8.x support after this version
elsif RUBY_VERSION =~ /^1\./
  gem 'cucumber', '< 2.0.0'
  gem 'mime-types', '< 3.0.0' # Requires Ruby 2.x on/after this version
end

if RUBY_VERSION =~ /^1\./
  gem 'tins', '< 1.7' # The 'tins' gem requires Ruby 2.x on/after this version
  gem 'json', '< 2.0' # The 'json' gem drops pre-Ruby 2.x support on/after this version
  gem 'term-ansicolor', '< 1.4' # The 'term-ansicolor' gem requires Ruby 2.x on/after this version
  gem 'unf_ext', '< 0.0.7.3' # Requires Ruby 2.x on/after this version
end

gem 'coveralls', :require => false, :group => :development

cuke_modeler_major_version = 3

if [0].include?(cuke_modeler_major_version)

  if RUBY_VERSION =~ /^2\./
    # Cucumber 4.x uses the `cucumber-gherkin` gem, which is incompatible with
    # the `gherkin` gem, upon which the `cuke_modeler` gem depends
    gem 'cucumber', '< 4.0'
  end

  # The oldest versions of the `cuke_modeler` gem did not properly limit their dependencies
  # and CukeModeler 0.x can not handle a higher Gherkin 5.x+
  gem 'gherkin', '< 5.0'
end

gem 'cuke_modeler', "~> #{cuke_modeler_major_version}.0"
