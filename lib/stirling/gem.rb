module Stirling
  class Gem
    @@loading_gems = Bundler.load.specs.map {|spec| spec.name}

    class << self
      def load? gem
        exist_gem = class_variable_get("@@loading_#{gem}") rescue nil
        if exist_gem
          exist_gem
        else
          class_variable_set "@@loading_#{gem}", @@loading_gems.include?(gem)
        end
      end
    end
  end
end
