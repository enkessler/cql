[![Gem Version](https://badge.fury.io/rb/cql.svg)](https://rubygems.org/gems/cql)
[![Dependency Status](https://gemnasium.com/enkessler/cql.svg)](https://gemnasium.com/enkessler/cql)
[![Build Status](https://travis-ci.org/enkessler/cql.svg?branch=dev)](https://travis-ci.org/enkessler/cql)
[![Build status](https://ci.appveyor.com/api/projects/status/ia3t0tkyj4tuobq8/branch/dev?svg=true)](https://ci.appveyor.com/project/enkessler/cql/branch/dev)
[![Coverage Status](https://coveralls.io/repos/enkessler/cql/badge.svg?branch=dev)](https://coveralls.io/github/enkessler/cql?branch=dev)
[![Code Quality](https://codeclimate.com/github/enkessler/cql/badges/gpa.svg)](https://codeclimate.com/github/enkessler/cql)
[![Project License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/enkessler/cql/blob/master/LICENSE.txt)


# CQL (Cucumber Query Language)

CQL is a domain specific language used for querying a Cucumber (or other Gherkin based) test suite. It is written 
in Ruby and powered by the [cuke_modeler](https://github.com/enkessler/cuke_modeler) gem. The goal of CQL is to increase the ease with which 
useful information can be extracted from a modeled test suite and turned into summarized data or reports.


Some uses for example are:

* Build systems
* Reporting

## Quick Start

* Install the gem

Use the following command:

    gem install cql

Alternatively you can add it to your Gemfile if you are using bundler.

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

Alternatively, you can activate the extensions to the cuke_modeler gem and query models directly:

    require 'cql'
    require 'cql/model_dsl'
    
    directory = CukeModeler::Directory.new("/path-to/my/feature-files")

    directory.query do
        select name, source_line
        from features
    end

For more information on the query options, see the [documentation](https://www.relishapp.com/enkessler/cql/docs).
