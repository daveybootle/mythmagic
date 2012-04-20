require File.expand_path('../test_helper.rb', __FILE__)

class ChannelMapTest < ActiveSupport::TestCase

  test "register_channel_in_channel_map creates unmapped channel" do
    unit = ChannelMap.new

    ideal_channel = {:ideal_name => 'My Ideal Name'}
    myth_channel = MockActiveRecordChannel.new
    myth_channel.sourceid = 1

    unit.register_channel(ideal_channel, myth_channel)
    
    channel_group = unit['My Ideal Name']
    assert_not_nil channel_group, "Could not find my channel in map"

    assert_not_nil channel_group.sources[1], "Source 1 had no channels"
    assert_equal myth_channel, channel_group.sources[1][0]
  end

  test "register_channel_in_channel_map adds to rather than overwriting existing channel" do
    unit = ChannelMap.new

    ideal_channel = {:ideal_name => 'My Ideal Name'}
    myth_channel_1 = MockActiveRecordChannel.new
    myth_channel_1.sourceid = 1

    unit.register_channel(ideal_channel, myth_channel_1)
   
    myth_channel_2 = MockActiveRecordChannel.new
    myth_channel_2.sourceid = 2

    unit.register_channel(ideal_channel, myth_channel_2)

    channel_group = unit['My Ideal Name']
    assert_not_nil channel_group, "Could not find my channel in map"

    assert_not_nil channel_group.sources[1], "Source 1 had no channels"
    assert_equal myth_channel_1, channel_group.sources[1][0]
    assert_not_nil channel_group.sources[2], "Source 2 had no channels"
    assert_equal myth_channel_2, channel_group.sources[2][0]
  end

  class MockActiveRecordChannel
    attr_accessor :saved, :sourceid, :visible, :icon, :channum, :name, :callsign, :xmltvid, :icon

    def self.find type
      return [MockActiveRecordChannel.new]
    end    
  end 
  
  test "write_changes_to_db tells each channel to write" do
    my_channel_group = MockChannelGroup.new

    unit = ChannelMap.new

    channel_group_1 = MockChannelGroup.new
    channel_group_2 = MockChannelGroup.new
    channel_group_3 = MockChannelGroup.new

    unit["name1"] = channel_group_1
    unit["name2"] = channel_group_2
    unit["name3"] = channel_group_3
    unit.write_changes_to_db
    
    assert channel_group_1.written
    assert channel_group_2.written
    assert channel_group_3.written
  end

  class MockChannelGroup
    attr_reader :written
    def writechannels
      @written = true
    end
  end

end
