module CukeModeler
  class Model

    # todo - this is common code that needs to be extracted out into a mix-in module or else it will get out of sync. Go do this now!
    def query(&block)
      CQL::Query.new(self, &block).data
    end

  end
end
