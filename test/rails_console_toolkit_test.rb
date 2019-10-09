require "test_helper"

class RailsConsoleToolkitTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RailsConsoleToolkit::VERSION
  end

  def test_helper
    RailsConsoleToolkit.helper(:foo) { :bar }
    RailsConsoleToolkit.install!(console_methods)

    assert_equal console_methods.foo, :bar
  end

  def test_alias
    RailsConsoleToolkit.helper(:foo) { :bar }
    RailsConsoleToolkit.helper(:quz) { |*args, &block| [args, block] }
    RailsConsoleToolkit.alias_helper(:baz, :foo)
    RailsConsoleToolkit.alias_helper(:boz, :quz)
    RailsConsoleToolkit.install!(console_methods)

    assert_equal console_methods.baz, :bar

    proc = method(:puts).to_proc
    assert_equal console_methods.boz(1,2,3, &proc), [
      [1,2,3],
      proc,
    ]
  end

  class DummyModel < Struct.new(:id, :name)
    DB = [
      new(1,"foo"),
      new(2,"bar"),
      new(3,"baz"),
    ]

    def self.find(id)
      DB.find { |r| r.id == id }
    end

    def self.find_by(name:)
      DB.find { |r| r.name == name }
    end

    def ==(other)
      self.class === other && id == other.id
    end
  end

  def test_model_helper
    RailsConsoleToolkit.model_helper 'RailsConsoleToolkitTest::DummyModel'
    RailsConsoleToolkit.model_helper 'RailsConsoleToolkitTest::DummyModel', as: :foo
    RailsConsoleToolkit.model_helper 'RailsConsoleToolkitTest::DummyModel', as: :foo_no_cache, cached: false
    RailsConsoleToolkit.model_helper 'RailsConsoleToolkitTest::DummyModel', as: :foo_name, by: [:name]
    RailsConsoleToolkit.model_helper 'RailsConsoleToolkitTest::DummyModel', as: :foo_name_no_cache, by: [:name], cached: false
    RailsConsoleToolkit.install!(console_methods)

    assert_nil(console_methods.rails_console_toolkit_test_dummy_model)
    DummyModel::DB.each.with_index(1) { |record, id| assert_model_helper(:rails_console_toolkit_test_dummy_model, id, record, record) }

    assert_nil(console_methods.foo)
    DummyModel::DB.each.with_index(1) { |record, id| assert_model_helper(:foo, id, record, record) }

    assert_nil(console_methods.foo_no_cache)
    DummyModel::DB.each.with_index(1) { |record, id| assert_model_helper(:foo_no_cache, id, record, nil) }

    assert_nil(console_methods.foo_name)
    DummyModel::DB.each.with_index(1) do |record, id|
      assert_model_helper(:foo_name, id, record, record)
      assert_model_helper(:foo_name, record.name, record, record)
    end

    assert_nil(console_methods.foo_name_no_cache)
    DummyModel::DB.each.with_index(1) do |record, id|
      assert_model_helper(:foo_name_no_cache, id, record, nil)
      assert_model_helper(:foo_name_no_cache, record.name, record, nil)
    end
  end

  def test_aliases_pack
    RailsConsoleToolkit.use_pack :aliases
    RailsConsoleToolkit.install!(console_methods)

    console_methods.define_method(:reload!) { 'reloaded' }
    console_methods.define_method(:exit) { 'exited' }

    assert_equal console_methods.r, 'reloaded'
    assert_equal console_methods.x, 'exited'
  end

  private

  # A dummy module to test out methods
  def console_methods
    @console_methods ||= Module.new { extend self }
  end

  def assert_model_helper(helper_name, id, record_with_id, record_without_id)
    assert_equal(
      record_with_id, console_methods.public_send(helper_name, id),
      "expected #{record_with_id.inspect} using: #{id.inspect} with helper #{helper_name}",
    )

    if record_without_id
      assert_equal(
        record_without_id, console_methods.public_send(helper_name),
        "expected #{record_without_id.inspect} after: #{id.inspect} with helper #{helper_name}",
      )
    else
      assert_nil(
        console_methods.public_send(helper_name),
        "expected nil after: #{id.inspect} with helper #{helper_name}",
      )
    end
  end
end
