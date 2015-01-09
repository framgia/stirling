module Stirling
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec
    end

    config.app_generators do |g|
      g.templates.unshift File::expand_path("../templates",  __FILE__)
    end
  end
end
