require "helper"

describe Crdt::ORSet do
  subject { Crdt::ORSet }

  it "adds" do
    result = subject.add(subject.create, "foo", -> { 1 })

    expected = Hamster.hash("foo" => [Hamster.set(1), Hamster.set])

    assert_equal(expected, result)
  end

  it "removes" do
    result = subject.add(subject.create, "foo", -> { 1 })
    result = subject.add(result, "foo", -> { 2 })
    result = subject.remove(result, "foo")

    expected = Hamster.hash("foo" => [Hamster.set(1, 2), Hamster.set(1, 2)])

    assert_equal(expected, result)
  end

  it "merges" do
    s1 = subject.add(subject.create, "foo", -> { 1 })
    s2 = subject.remove(subject.add(s1, "bar", -> { 2 }), "foo")

    expected = Hamster.hash(
      "foo" => [Hamster.set(1), Hamster.set(1)],
      "bar" => [Hamster.set(2), Hamster.set]
    )

    assert_equal(expected, subject.merge(s1, s2))
  end

  it "values" do
    s1 = subject.create
    s2 = subject.add(s1, "foo", -> { 1 })
    s3 = subject.remove(s2, "foo")
    s4 = subject.add(s3, "foo", -> { 2 })
    s5 = subject.add(s4, "bar", -> { 2 })

    assert_equal(Hamster.set, subject.value(s1))
    assert_equal(Hamster.set("foo"), subject.value(s2))
    assert_equal(Hamster.set, subject.value(s3))
    assert_equal(Hamster.set("foo"), subject.value(s4))
    assert_equal(Hamster.set("foo", "bar"), subject.value(s5))
  end
end
