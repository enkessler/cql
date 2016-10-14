module CQL
  module Queriable

    attr_accessor :query_root


    def query(&block)
      raise(ArgumentError, 'Query cannot be run. No query root has been set.') unless @query_root

      Query.new(@query_root, &block).data
    end

  end
end
