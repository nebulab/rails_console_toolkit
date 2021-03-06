require "active_support/core_ext/string/inflections"

module RailsConsoleToolkit::Helpers
  def use_pack pack_name
    unless %w[aliases solidus utils].include? pack_name.to_s
      raise Error, "unknown pack name: #{pack_name}"
    end

    require "rails_console_toolkit/#{pack_name}"
  end

  def install!(target_module = Rails::ConsoleMethods)
    helper_methods.each do |name, block|
      target_module.define_method(name, &block)
    end
  end

  def helper(name, &block)
    helper_methods[name.to_sym] = block
  end

  def model_helper(klass_name, as: nil, by: nil, cached: true)
    unless String === klass_name
      raise TypeError, "The class name is expected to be a String, got #{klass_name.inspect} (#{klass_name.class}) instead."
    end

    method_name = as || klass_name.gsub('::', '_').underscore
    attribute_names = by || []

    record = nil # use the closure as a cache

    helper method_name do |key = nil|
      klass = klass_name.constantize
      record = nil unless cached

      if key
        record = nil
        record = key if klass === key
        record ||= klass.find(key) if Numeric === key
        attribute_names.find { |name| record ||= klass.find_by(name => key) }
      end

      record
    end
  end

  def alias_helper(new_name, old_name)
    helper(new_name) { |*args, &block| send(old_name, *args, &block) }
  end

  def remove_helper(name)
    helper_methods.delete(name.to_sym)
  end

  private

  def helper_methods
    @helper_methods ||= {}
  end
end
