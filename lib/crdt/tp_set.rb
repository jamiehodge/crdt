module Crdt
  module TPSet
    extend self

    def create
      [GSet.create, GSet.create]
    end

    def add(sets, value)
      [GSet.add(sets.first, value), sets.last]
    end

    def remove(sets, value)
      raise ArgumentError unless sets.first.include?(value)
      [sets.first, GSet.add(sets.last, value)]
    end

    def merge(sets, other)
      sets.zip(other).map {|a,b| GSet.merge(a,b) }
    end

    def value(sets)
      sets.inject(:-)
    end
  end
end
