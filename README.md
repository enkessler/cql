[![Gem Version](https://badge.fury.io/rb/cql.svg)](https://rubygems.org/gems/cql)
[![Build Status](https://travis-ci.org/enkessler/cql.svg?branch=dev)](https://travis-ci.org/enkessler/cql)
[![Coverage Status](https://coveralls.io/repos/enkessler/cql/badge.svg)](https://coveralls.io/github/enkessler/cql)
[![Code Quality](https://codeclimate.com/github/enkessler/cql/badges/gpa.svg)](https://codeclimate.com/github/enkessler/cql)
[![Dependency Status](https://gemnasium.com/enkessler/cql.svg)](https://gemnasium.com/enkessler/cql)



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

Now that you have a repository you can write a query. A simple example is given below

    cql_repo.query do
        select name, source_line
        from features
    end

This will return a list of all of the feature names in the form of a list of hashes.

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
