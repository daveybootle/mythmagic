require 'simplecov'
SimpleCov.start do
    add_filter "/test/"
end

require 'active_record'
require 'test/unit'

Dir[File.expand_path('../../classes/*.rb', __FILE__)].each{ |file| require file }

