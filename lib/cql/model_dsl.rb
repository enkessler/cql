# todo - add some sore of error/warning if loading with the 0.x cuke_modeler?

module CukeModeler
  class Model

    include CQL::Queriable

    alias_method :original_initialize, :initialize


    def initialize(source_text = nil)
      original_initialize(source_text)

      @query_root = self
    end

  end
end
