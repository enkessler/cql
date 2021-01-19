module CQL

  # A mix-in module containing methods used by objects that want to be able to run queries against objects (often themselves).
  module Queriable

    # The object against which the query will be run.
    attr_accessor :query_root # todo - deprecate this such that queries are always performed against *self*


    # Performs a query against the current *query_root*
    def query(&block)
      raise(ArgumentError, 'Query cannot be run. No query root has been set.') unless @query_root

      Query.new(@query_root, &block).data
    end

  end
end
