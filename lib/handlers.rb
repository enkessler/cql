module CQL
  class UnaryHandler
    def initialize next_handler
      @next = next_handler
    end

    def handle what, data
      return @next.handle(what, data) if what == Array
      CQL::MapReduce.send(what, data)
    end
  end

  class MultiHandler
    def initialize next_handler
      @next = next_handler
    end

    def handle what, data
      return @next.handle(what, data) if what != Array || CQL::QUERY_VALUES.include?(what)
      result = Array.new(data.size)
      result = result.map { |e| {} }
      what.each do |w|
        CQL::MapReduce.send(w, data).each_with_index do |e, i|
          result[i][w] = e
        end
      end
      result.size == 1 ? result.first : result
    end
  end

  class SpecialHandler
    def initialize next_handler
      @next = next_handler
    end

    def handle what, data
      "next"
    end
  end
end