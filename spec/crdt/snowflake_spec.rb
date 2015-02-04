require "helper"

describe Crdt::Snowflake do
  subject { Crdt::Snowflake }

  it "gen_ids" do
    subject.set_clock(1288834974658)
    assert_equal(4472832, subject.gen_id(2, 4))
    assert_equal(4472833, subject.gen_id(2, 4))
  end
end
