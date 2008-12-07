require File.dirname(__FILE__) + "/lib/has_one_accessor"
ActiveRecord::Base.extend HasOneAccessor::ActsMethods
