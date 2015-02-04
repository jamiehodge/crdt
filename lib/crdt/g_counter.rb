module Crdt
  module GCounter
    extend self

    def create
      Hamster.hash
    end

    def increment(counter, delta, node = Crdt.node)
      counter.put(node) {|v| v.to_i + delta.to_i }
    end

    def merge(counter, other)
      array = (counter.keys | other.keys).map do |key|
        [key, [counter[key].to_i, other[key].to_i].max]
      end

      Hamster.hash(array)
    end

    def value(counter)
      counter.values.sum
    end
  end
end
