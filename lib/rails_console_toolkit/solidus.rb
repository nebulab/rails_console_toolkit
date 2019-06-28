RailsConsoleToolkit.helper :load_factories do
  require 'factory_bot'
  require 'spree/testing_support/factories'
  FactoryBot.find_definitions
  Rails::ConsoleMethods.send :include, ::FactoryBot::Syntax::Methods
end

RailsConsoleToolkit.model_helper Spree::Product, as: :product, by: [:slug, :name]
RailsConsoleToolkit.model_helper Spree::Variant, as: :variant, by: [:sku]
RailsConsoleToolkit.model_helper Spree::Taxon, as: :taxon, by: [:permalink]
RailsConsoleToolkit.model_helper Spree::Order, as: :order, by: [:number]
RailsConsoleToolkit.model_helper Spree::User, as: :user, by: [:email]
RailsConsoleToolkit.model_helper Spree::Country, as: :country, by: [:iso, :iso3, :iso_name, :name]
