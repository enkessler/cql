lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cql/version'


Gem::Specification.new do |s| # rubocop:disable Metrics/BlockLength - Gemspecs inherently have a lot of lines
  s.name        = 'cql'
  s.version     = CQL::VERSION
  s.authors     = ['Eric Kessler', 'Jarrod Folino']
  s.summary     = 'A gem providing functionality to query a Cucumber test suite.'
  s.description = ['CQL is a domain specific language used for querying a Cucumber (or other Gherkin based) test ',
                   'suite. The goal of CQL is to increase the ease with which useful information can be extracted ',
                   'from a modeled test suite and turned into summarized data or reports.'].join
  s.email       = ['morrow748@gmail.com']
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/enkessler/cql'
  s.platform    = Gem::Platform::RUBY
  s.metadata    = {
    'bug_tracker_uri'   => 'https://github.com/enkessler/cql/issues',
    'changelog_uri'     => 'https://github.com/enkessler/cql/blob/master/CHANGELOG.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/cql',
    'homepage_uri'      => 'https://github.com/enkessler/cql',
    'source_code_uri'   => 'https://github.com/enkessler/cql'
  }

  s.required_ruby_version = '>= 2.0', '< 4.0'

  s.add_runtime_dependency 'cuke_modeler', '>= 1.0', '< 4.0'

  s.add_development_dependency 'childprocess', '< 5.0'
  s.add_development_dependency 'ffi', '< 2.0'  # This is an invisible dependency for the `childprocess` gem on Windows
  s.add_development_dependency 'rake', '< 13.0.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'cucumber', '< 5.0.0'
  s.add_development_dependency 'simplecov', '< 1.0.0'
  s.add_development_dependency 'coveralls', '< 1.0.0'
  s.add_development_dependency 'bundler', '< 3.0'
  s.add_development_dependency 'rainbow', '< 4.0.0'
  s.add_development_dependency 'yard', '< 1.0'
  s.add_development_dependency 'rubocop', '<= 0.50.0' # RuboCop can not lint against Ruby 2.0 after this version


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path('', __dir__)) do
    source_controlled_files = `git ls-files -z`.split("\x0")
    source_controlled_files.keep_if { |file| file =~ %r{^(lib|testing/cucumber/features)} }
    source_controlled_files + ['README.md', 'LICENSE.txt', 'CHANGELOG.md', 'cql.gemspec']
  end

  s.require_paths = ['lib']
end
