module Crdt
  module GSet
    extend self

    def create
      Hamster.set
    end

    def add(set, value)
      set << value
    end

    def merge(set, other)
      set | other
    end

    def value(set)
      set
    end
  end
end
