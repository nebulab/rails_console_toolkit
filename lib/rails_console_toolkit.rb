require "rails_console_toolkit/version"

module RailsConsoleToolkit
  autoload :Helpers, "rails_console_toolkit/helpers"

  class Error < StandardError; end

  def self.setup
    extend Helpers
  end

  def self.configure(&block)
    Rails.application.console do
      setup
      block.call(self)
      install!
    end
  end
end
