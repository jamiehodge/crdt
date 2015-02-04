require "helper"

describe Crdt::GSet do
  subject { Crdt::GSet }

  it "adds" do
    assert_equal(Hamster.set("foo"), subject.add(subject.create, "foo"))
  end

  it "merges" do
    s1 = subject.add(subject.create, "foo")
    s2 = subject.add(subject.create, "bar")

    assert_equal(Hamster.set("foo", "bar"), subject.merge(s1, s2))
  end

  it "values" do
    assert_equal(Hamster.set("foo"), subject.add(subject.create, "foo"))
  end
end
