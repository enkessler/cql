module CQL

# A repository is a group of models. See the corresponding Cucumber documentation for details.

  class Repository

    include Queriable


    def initialize(repository_root)
      case
        when repository_root.is_a?(String)
          root = CukeModeler::Directory.new(repository_root)
        when repository_root.class.to_s =~ /CukeModeler/
          root = repository_root
        else
          raise(ArgumentError, "Don't know how to make a repository from a #{repository_root.class}")
      end

      @query_root = root
    end

  end
end
