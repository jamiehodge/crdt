require "concurrent/atomic"
require "concurrent/extension"

module Crdt
  module Snowflake
    extend self

    TW_EPOCH = 1288834974657

    def id_seq
      seq.update do |seq|
        ts, s = seq
        now = tick

        if ts == now
          [ts, s.succ & 0xffff]
        else
          [now, 0]
        end
      end
    end

    def gen_id(dc, worker)
      ts, id = id_seq

      (((ts - TW_EPOCH) << 22 ) | (dc << 17) | (worker << 12)) | id
    end

    def seq
      @seq ||= Concurrent::Atomic.new([0,0])
    end

    def clock
      @clock ||= Concurrent::Atomic.new(-> { Time.new.sec * 1000 })
    end

    def tick
      clock.value.call
    end

    def set_clock(c)
      clock.set(-> { c })
    end
  end
end
