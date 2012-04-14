require File.expand_path('../test_helper.rb', __FILE__)

class MagicMythMapperTest < ActiveSupport::TestCase

  test "Something" do
#    unit = MagicMythMapper.new(MockActiveRecordChannel)
    assert true
  end
 
  class MockActiveRecordChannel
    attr_accessor :saved, :sourceid, :visible, :icon, :channum, :name, :callsign, :xmltvid, :icon

    def self.find type
      return [MockActiveRecordChannel.new]
    end    
  end 
end
