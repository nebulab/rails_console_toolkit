require "rails_console_toolkit/version"
require "active_support/core_ext/string/inflections"

module RailsConsoleToolkit
  extend self

  class Error < StandardError; end

  def install!
    require 'rails/console/app'

    helper_methods.each do |name, block|
      Rails::ConsoleMethods.define_method(name, &block)
    end
  end

  def helper(name, &block)
    helper_methods[name.to_sym] = block
  end

  def model_helper(klass, as: nil, by: nil, cached: true)
    klass = klass.constantize if klass.respond_to? :constantize
    method_name = as || klass.name.gsub('::', '_').underscore
    cache_key = method_name
    attribute_names = by || []

    record = nil # use the closure as a cache

    helper method_name do |key = nil|
      unless cached
        record = nil
        raise("missing key for #{key}") unless key
      end

      if key
        record ||= klass.find(key) if key.is_a? Numeric
        attribute_names.find { |name| record ||= klass.find_by(name => key) }
      end

      record
    end
  end

  def alias_helper(new_name, old_name)
    helper(new_name) { send(old_name) }
  end

  def remove_helper(name)
    helper_methods.delete(name.to_sym)
  end

  private

  def helper_methods
    @helper_methods ||= {}
  end
end
