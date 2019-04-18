# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'cql/version'


Gem::Specification.new do |s|
  s.name        = 'cql'
  s.version     = CQL::VERSION
  s.authors     = ['Eric Kessler', 'Jarrod Folino']
  s.summary     = "A gem providing functionality to query a Cucumber test suite."
  s.description = 'CQL is a domain specific language used for querying a Cucumber (or other Gherkin based) test suite. The goal of CQL is to increase the ease with which useful information can be extracted from a modeled test suite and turned into summarized data or reports.'
  s.email       = 'morrow748@gmail.com'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/enkessler/cql'

  s.platform    = Gem::Platform::RUBY
  s.post_install_message = %{
(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

Thank you for installing cql (Cucumber Query Language)

(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

}

  s.add_runtime_dependency 'cuke_modeler', '< 2.0'

  s.add_development_dependency 'rake', '< 13.0.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'cucumber', '< 3.0.0'
  s.add_development_dependency 'simplecov', '< 1.0.0'
  s.add_development_dependency 'racatt', '~> 1.0'
  s.add_development_dependency 'coveralls', '< 1.0.0'
  s.add_development_dependency 'bundler', '< 3.0'
  s.add_development_dependency 'rainbow', '< 4.0.0'


  s.files            = Dir.glob('lib/**/*').reject { |path| path =~ /\.gitignore$/ }
  s.test_files       = Dir.glob('testing/**/*')
  s.rdoc_options     = ['--charset=UTF-8']
  s.require_path     = 'lib'
end
