Basic stuff:
[![Gem Version](https://badge.fury.io/rb/cql.svg)](https://rubygems.org/gems/cql)
[![Project License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/mit-license.php)
[![Downloads](https://img.shields.io/gem/dt/cql.svg)](https://rubygems.org/gems/cql)

User stuff:
[![Cucumber Docs](http://img.shields.io/badge/Documentation-Features-green.svg)](https://github.com/enkessler/cql/tree/master/testing/cucumber/features)
[![Yard Docs](http://img.shields.io/badge/Documentation-API-blue.svg)](https://www.rubydoc.info/gems/cql)

Developer stuff:
[![Build Status](https://github.com/enkessler/cql/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/enkessler/cql/actions/workflows/ci.yml?query=branch%3Amaster)
[![Coverage Status](https://coveralls.io/repos/github/enkessler/cql/badge.svg?branch=master)](https://coveralls.io/github/enkessler/cql?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/a469e37db8e67c1c989b/maintainability)](https://codeclimate.com/github/enkessler/cql/maintainability)
[![Inline docs](http://inch-ci.org/github/enkessler/cql.svg?branch=master)](https://inch-ci.org/github/enkessler/cql)

---


# CQL (Cucumber Query Language)

CQL is a domain specific language used for querying a Cucumber (or other Gherkin based) test suite. It is written 
in Ruby and powered by the [cuke_modeler](https://github.com/enkessler/cuke_modeler) gem. The goal of CQL is to increase the ease with which 
useful information can be extracted from a modeled test suite and turned into summarized data or reports.


Some uses for example are:

* Build systems
* Reporting


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cql'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cql

## Usage

* Create a new ruby file and require the gem

        require 'cql'

* Start querying things!

The first thing that needs to be done is to create a CQL Repository. This can be done with the following line:

    require 'cql'
    cql_repo = CQL::Repository.new "/path-to/my/feature-files"

Repositories can also be created from an existing model:

    directory = CukeModeler::Directory.new("/path-to/my/feature-files")
    cql_repo = CQL::Repository.new(directory)

Now that you have a repository you can write a query. A simple example is given below

    cql_repo.query do
        select name, source_line
        from features
    end

This will return a list of all of the feature names and source lines in the form of a list of hashes.

    [{'name' => 'Feature 1', 'source_line' => 1},
     {'name' => 'Feature 2', 'source_line' => 3},
     {'name' => 'Feature 3', 'source_line' => 10}]

Alternatively, you can activate the extensions to the `cuke_modeler` gem and query models directly:

    require 'cql'
    require 'cql/model_dsl'
    
    directory = CukeModeler::Directory.new("/path-to/my/feature-files")

    directory.query do
        select name, source_line
        from features
    end

For more information on the query options, see the documentation [here](https://github.com/enkessler/cql/tree/master/testing/cucumber/features).

## Development and Contributing

See [CONTRIBUTING.md](https://github.com/enkessler/cql/blob/master/CONTRIBUTING.md)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


