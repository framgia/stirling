module Stirling
  class Gem
    @@loading_gem = Bundler.load.specs.map {|spec| spec.name}

    class << self
      def load? gem
        @@loading_gem.include? gem
      end
    end
  end
end
