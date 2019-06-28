RailsConsoleToolkit.helper :benchmark do |*args,&block|
  @benchmarker ||= begin
    benchmarker = Object.new
    def benchmarker.logger
      Rails.logger
    end
    benchmarker.extend ActiveSupport::Benchmarkable
    benchmarker
  end

  @benchmarker.benchmark(*args, &block)
end

RailsConsoleToolkit.alias_helper :bm, :benchmark
