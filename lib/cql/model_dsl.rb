module CukeModeler

  # A monkey patch that allows models to be queried directly by having them use this gem's query module.

  class Model

    include CQL::Queriable


    # Hanging on to the original method so that it can be invoked and thus ensure that all of the normal, un-patched behavior occurs
    alias_method :original_initialize, :initialize


    # Sets itself as the model's *query_root*. Otherwise, as per the un-patched method.
    def initialize(source_text = nil)
      original_initialize(source_text)

      @query_root = self
    end

  end
end
