require "rails_console_toolkit/version"

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

  private

  def helper_methods
    @helper_methods ||= {}
  end
end
