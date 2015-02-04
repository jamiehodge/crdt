require "helper"

describe Crdt::GCounter do
  subject { Crdt::GCounter }

  it "increments" do
    assert_equal({ foo: 1 }, subject.increment(subject.create, 1, :foo))
  end

  it "increments with delta" do
    existing = subject.increment(subject.create, 1, :foo)

    assert_equal({ foo: 3 }, subject.increment(existing, 2, :foo))
  end

  it "merges" do
    c1 = subject.increment(subject.create, 1, :foo)
    c2 = subject.increment(subject.create, 2, :bar)
    c3 = subject.increment(c1, 1, :bar)

    assert_equal({ foo: 1, bar: 2 }, subject.merge(c1, c2))
    assert_equal({ foo: 1, bar: 2 }, subject.merge(c2, c3))
    assert_equal({ foo: 1, bar: 1 }, subject.merge(c1, c3))
  end

  it "values" do
    c = subject.increment(subject.increment(subject.create, 1, :foo), 2, :bar)

    assert_equal(3, subject.value(c))
  end
end
