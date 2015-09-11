Feature: Repository

  All queries are performed against a repository object. A repository is simply a collection of models that represent a Cucumber test suite. Commonly, a repository is created based on a file path that is the location of such a test suite. However, repositories can also be created using any model as their starting point.


  Scenario: Using a file path to create a repository
    Given a directory "path/to/test_directory"
    Then the following code executes without error:
    """
    CQL::Repository.new("path/to/test_directory")
    """

  Scenario: Using a model to create a repository

  Note: Non-directory models can also be used

    Given a directory "path/to/test_directory"
    Then the following code executes without error:
    """
    directory_model = CukeModeler::Directory.new("path/to/test_directory")

    CQL::Repository.new(directory_model)
    """
