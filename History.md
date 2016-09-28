### Version 1.2.1 / 2016-09-28

* The gem now declares version limits on all of its dependencies.

### Version 1.2.0 / 2016-09-26

* Added support for the 1.x series of the 'cuke_modeler' gem.

### Version 1.1.0 / 2015-11-28

* Bug fix: Fixed a bug that could cause a targeted transform to be applied to a target other than the intended one.
* Targeting added for the 'with' clause.
* Alternate syntax for model selection added.
* Dropping usage of the 'backports' gem in order to not introduce unneeded gem dependencies into user applications.
* Better error feedback.

### Version 1.0.1 / 2015-09-20

* Bug fix: Repository instantiation using models now works correctly.
* Better error feedback.

### Version 1.0.0 / 2015-09-11

* Several new clauses have been added to the DSL
* Queries are now made dynamically and directly against the underlying models instead of having a limited set
  of predefined query methods. Some predefined query methods have been retained.

### Version 0.3.0 / 2014-07-18

* Swapped out the back end of the gem so that it is powered by the 'cuke_modeler'
  gem instead of using the 'gherkin' gem directly

### Version 0.2.1 / 2013-07-18

* The Great Before Times...
