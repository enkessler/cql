# CQL (Cucumber Query Language)

CQL is a domain specific language used for querying feature files. It is written in ruby. The
goal of CQL is to enable to create summarized data on the collection of feature files. Some uses for example are:

* Build systems
* Reporting

# Quick Start

* Install the gem

Use the following command:

```bash
gem install cql
```

Alternatively you can add it to your Gemfile if you are using bundler

* Create a new ruby file

* The first thing that needs to be done is to create a CQL Repository. This can be done with the following line:

```ruby
   cql_repo = CQL::Repository.new "/path-to-my-feature-files"
```

* Now that you have a repository you can write a query. A simple example is given below

```ruby
   cql_repo = CQL::Repository.new "/path-to-my-feature-files"
   result = gs.query do
        select name
        from features
   end
```
This will return a list of all of the feature names in the form of a list of hashes.

# CQL DSL
## The 'from' clause

The following values are supported for the 'from' clause:

 * scenario_outlines
 * scenarios
 * features

To select all names from scenarios use:

```ruby
   cql_repo = CQL::Repository.new "/path-to-my-feature-files"
   result = gs.query do
        select name
        from scenarios
   end
```

To select all names from scenario_outlines use:

```ruby
   cql_repo = CQL::Repository.new "/path-to-my-feature-files"
   result = gs.query do
        select name
        from scenario_outlines
   end
```

To select all names from features use:

```ruby
   cql_repo = CQL::Repository.new "/path-to-my-feature-files"
   result = gs.query do
        select name
        from features
   end
```
## The 'select' clause
**Need help?** Please email me directly at jdfolino@gmail.com