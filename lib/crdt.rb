require_relative "crdt/version"

require_relative "crdt/g_counter"
require_relative "crdt/g_set"
require_relative "crdt/or_set"
require_relative "crdt/pn_counter"
require_relative "crdt/snowflake"
require_relative "crdt/tp_set"

require "hamster"
require "socket"

module Crdt
  extend self

  def node
    Socket.gethostname
  end
end
