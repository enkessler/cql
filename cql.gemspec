# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'cucumber/platform'

Gem::Specification.new do |s|
  s.name        = 'cql'
  s.version     = '0.2.1'
  s.authors     = ['Jarrod Folino']
  s.description = 'Cucumber Query Language'
  s.summary     = "cucumber-#{s.version}"
  s.email       = 'jdfolino@gmail.com'

  s.platform    = Gem::Platform::RUBY
  s.post_install_message = %{
(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

Thank you for installing cql (Cucumber Query Language)

(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

}

  s.add_runtime_dependency 'cucumber_analytics', '~>1.2.0'
  s.add_runtime_dependency 'json', '>= 1.4.6'

  s.add_development_dependency 'rake', '>= 0.9'
  s.add_development_dependency 'rspec', '~> 2.7'


  s.rubygems_version = '>= 1.6.1'
  s.files            = Dir.glob('lib/*').reject {|path| path =~ /\.gitignore$/ }
  s.test_files       = Dir.glob('spec/*')
  s.rdoc_options     = ['--charset=UTF-8']
  s.require_path     = 'lib'
end