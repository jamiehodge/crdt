require "helper"

describe Crdt::TPSet do
  subject { Crdt::TPSet }

  it "adds" do
    assert_equal([Hamster.set("foo"), Hamster.set], subject.add(subject.create, "foo"))
  end

  it "removes" do
    result = subject.remove(subject.add(subject.create, "foo"), "foo")

    assert_equal([Hamster.set("foo"), Hamster.set("foo")], result)
  end

  it "merges" do
    s1 = subject.add(subject.create, "foo")
    s2 = subject.remove(subject.add(subject.create, "bar"), "bar")

    assert_equal([Hamster.set("foo", "bar"), Hamster.set("bar")], subject.merge(s1, s2))
  end

  it "values" do
    assert_equal([Hamster.set("foo"), Hamster.set], subject.add(subject.create, "foo"))
  end
end
