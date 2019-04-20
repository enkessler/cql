# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Nothing yet...


## [1.5.1] - 2019-04-19

### Added

 - Add dependency version limits to Ruby which was previously unbound


## [1.5.0] - 2018-06-20

### Added

 - Added a new predefined 'with' clause filter ('eq') for checking equality, rather than having to use 'gte' and 'lte' in 
   conjunction.

### Changed

 - Reorganized some of the documentation and added more code examples.

### Fixed

 - Fixed a typo in the `.gemspec` description


## [1.4.2] - 2018-01-01

### Changed

 - New documentation locations added.


## [1.4.1] - 2017-06-10

### Changed

 - Improved the documentation of the project.


## [1.4.0] - 2017-04-08

### Fixed

 - The documented use case of selecting the same attribute multiple times is not, in fact, possible due to 
   the fact that results are a map type object (thus, they cannot have the same key more than once). This results in the 
   duplicate selections of an attribute overwriting the earlier selections. This data loss can be avoided by using the 
   'as' clause to rename the selections such that they all have unique key values. A warning has been added that is 
   triggered when duplicate attribute selections are detected but no 'as' clause is used.


## [1.3.0] - 2016-10-14

### Added

 - A new 'without' clause has been added. This clause has the opposite effect of the 'with' clause.
 - An optional extension to the 'cuke_modeler' gem has been added. This extension allows models to be directly 
   queried in the same manner that a repository could be queried (without needing the extra step of having to create 
   a repository out of the model first). This extension does not work with the 0.x versions of 'cuke_modeler'.
 - A special scoping identifier, :all, has been added that allows all types of model to be included with the 'from' 
   clause without having to explicitly list each model type.
 - A special selection identifier, :model, has been added that is a more meaningful alias for the :self identifier.

### Changed

 - More useful error messages.

### Fixed
 
 - The same model instances that are being queried will be returned in the results of a query. Previously, due to 
   efforts to avoid accidentally modifying the repository during the internal query process, copies of the models 
   were returned instead of the original instances. This was unintentional and has been fixed.


## [1.2.1] - 2016-09-28

### Added

 - The gem now declares version limits on all of its dependencies.


## [1.2.0] - 2016-09-26

### Added

 - Added support for the 1.x series of the 'cuke_modeler' gem.


## [1.1.0] - 2015-11-28

### Added

 - Targeting added for the 'with' clause.
 - Alternate syntax for model selection added.

### Changed

 - Better error feedback.

### Removed

 - Dropping usage of the 'backports' gem in order to not introduce unneeded gem dependencies into user applications.

### Fixed

 - Fixed a bug that could cause a targeted transform to be applied to a target other than the intended one.


## [1.0.1] - 2015-09-20

### Changed

 - Better error feedback.

### Fixed

 - Repository instantiation using models now works correctly.


## [1.0.0] - 2015-09-11

### Added

 - Several new clauses have been added to the DSL

### Changed

 - Queries are now made dynamically and directly against the underlying models instead of having a limited set
   of predefined query methods. Some predefined query methods have been retained.

## 0.3.0 - 2014-07-18

### Changed

 - Swapped out the back end of the gem so that it is powered by the 'cuke_modeler'
   gem instead of using the 'gherkin' gem directly

## 0.2.1 - 2013-07-18

* The Great Before Times...


[Unreleased]: https://github.com/enkessler/cuke_modeler/compare/v1.5.0...HEAD
[1.5.1]: https://github.com/enkessler/cql/compare/v1.5.0...v1.5.1
[1.5.0]: https://github.com/enkessler/cql/compare/v1.4.2...v1.5.0
[1.4.2]: https://github.com/enkessler/cql/compare/v1.4.1...v1.4.2
[1.4.1]: https://github.com/enkessler/cql/compare/v1.4.0...v1.4.1
[1.4.0]: https://github.com/enkessler/cql/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/enkessler/cql/compare/v1.2.1...v1.3.0
[1.2.1]: https://github.com/enkessler/cql/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/enkessler/cql/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/enkessler/cql/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/enkessler/cql/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/enkessler/cql/compare/v0.3.0...v1.0.0
