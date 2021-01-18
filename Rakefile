require 'bundler/gem_tasks'
require 'rake'
require 'rainbow'

Rainbow.enabled = true

require_relative 'rakefiles/ci_tasks'
require_relative 'rakefiles/documentation_tasks'
require_relative 'rakefiles/other_tasks'
require_relative 'rakefiles/release_tasks'
require_relative 'rakefiles/testing_tasks'


task :default => 'cql:test_everything'
