module Crdt
  module PNCounter
    extend self

    def create
      [ GCounter.create, GCounter.create ]
    end

    def increment(counters, delta, node = Crdt.node)
      [
        GCounter.increment(counters.first, delta, node),
        counters.last
      ]
    end

    def decrement(counters, delta, node = Crdt.node)
      [
        counters.first,
        GCounter.increment(counters.last, delta, node)
      ]
    end

    def merge(counters, other)
      counters.zip(other).map {|a,b| GCounter.merge(a, b) }
    end

    def value(counters)
      counters.map {|c| GCounter.value(c) }.reduce(:-)
    end
  end
end
