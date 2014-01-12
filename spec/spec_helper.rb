require File.expand_path('../../lib/scoping', __FILE__)
require 'rspec/autorun'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'
end
