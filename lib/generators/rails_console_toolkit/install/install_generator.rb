# frozen_string_literal: true

module RailsConsoleToolkit
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def copy_initializer
        copy_file 'initializer.rb', 'config/initializers/console.rb'
      end
    end
  end
end
