### Version 1.3.0 / 2016-10-14

* A new 'without' clause has been added. This clause has the opposite effect of the 'with' clause.
* An optional extension to the 'cuke_modeler' gem has been added. This extension allows models to be directly 
  queried in the same manner that a repository could be queried (without needing the extra step of having to create 
  a repository out of the model first). This extension does not work with the 0.x versions of 'cuke_modeler'.
* A special scoping identifier, :all, has been added that allows all types of model to be included with the 'from' 
  clause without having to explicitly list each model type.
* A special selection identifier, :model, has been added that is a more meaningful alias for the :self identifier.
* The same model instances that are being queried will be returned in the results of a query. Previously, due to 
  efforts to avoid accidentally modifying the repository during the internal query process, copies of the models 
  were returned instead of the original instances. This was unintentional and has been fixed.
* More useful error messages.

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
