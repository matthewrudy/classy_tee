unless defined?(HasOneAccessor)
  require File.dirname(__FILE__) + "/vendor/has_one_accessor/init"
end
require File.dirname(__FILE__) + "/lib/classy_tee"
ActiveRecord::Base.extend ClassyTee::ActsMethods