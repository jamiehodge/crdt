module Crdt
  module ORSet
    extend self

    def create
      Hamster.hash
    end

    def add(set, value, tag = -> { Snowflake.gen_id })
      set.put(value) do |v|
        current = v || TPSet.create
        TPSet.add(current, tag.call)
      end
    end

    def remove(set, value)
      set.put(value) do |v|
        current = v || TPSet.create
        [current.first, GSet.merge(*current)]
      end
    end

    def merge(set, other)
      array = (set.keys | other.keys).map do |key|
        a = set.fetch(key) { TPSet.create }
        b = other.fetch(key) { TPSet.create }

        [key, TPSet.merge(a, b)]
      end

      Hamster.hash(array)
    end

    def value(set)
      set.map {|k,v| [k, TPSet.value(v)] }.reject {|k,v| v.empty? }.keys
    end
  end
end
