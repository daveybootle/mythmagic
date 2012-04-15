require File.expand_path('../test_helper.rb', __FILE__)

class MagicMythMapperTest < ActiveSupport::TestCase

  test "register_channel_in_channel_map creates unmapped channel" do
    unit = MagicMythMapper.new

    ideal_channel = {:ideal_name => 'My Ideal Name'}
    myth_channel = MockActiveRecordChannel.new
    myth_channel.sourceid = 1

    unit.register_channel_in_channel_map(ideal_channel, myth_channel)
    
    channel_group = unit.channel_map['My Ideal Name']
    assert_not_nil channel_group, "Could not find my channel in map"

    assert_not_nil channel_group.sources[1], "Source 1 had no channels"
    assert_equal myth_channel, channel_group.sources[1][0]
  end

  test "register_channel_in_channel_map adds to rather than overwriting existing channel" do
    unit = MagicMythMapper.new

    ideal_channel = {:ideal_name => 'My Ideal Name'}
    myth_channel_1 = MockActiveRecordChannel.new
    myth_channel_1.sourceid = 1

    unit.register_channel_in_channel_map(ideal_channel, myth_channel_1)
   
    myth_channel_2 = MockActiveRecordChannel.new
    myth_channel_2.sourceid = 2

    unit.register_channel_in_channel_map(ideal_channel, myth_channel_2)

    channel_group = unit.channel_map['My Ideal Name']
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

  test "process_channel registers myth channel using ideal name" do
    unit = MagicMythMapper.new
    def unit.lookup_ideal_channel(name)
      {:ideal_name => "My Ideal Name", :ignore => false}
    end
    assert_equal "My Ideal Name", unit.lookup_ideal_channel("blah")[:ideal_name]

    myth_channel = MockActiveRecordChannel.new
    myth_channel.sourceid = 4

    unit.process_channel myth_channel
    channel_group = unit.channel_map['My Ideal Name']
    assert_not_nil channel_group, "Channel Group not found"
    assert_not_nil channel_group.sources[4], "Source 4 had no channels"
    assert_equal myth_channel, channel_group.sources[4][0]
  end

  test "process_channel records unmatched channels" do
    unit = MagicMythMapper.new
    def unit.lookup_ideal_channel(name)
      nil
    end

    myth_channel = MockActiveRecordChannel.new
    myth_channel.name = "Non matching channel"

    unit.process_channel myth_channel

    assert_equal 1, unit.unmatched_channel_names.length, "Expected to see one unmatched channel"
    assert_equal "Non matching channel", unit.unmatched_channel_names[0]
  end

  test "process_channel ignores channels with :ignore true" do
    unit = MagicMythMapper.new
    def unit.lookup_ideal_channel(name)
      {:ideal_name => "Ignorable Channel", :ignore => true}
    end
    assert unit.lookup_ideal_channel("blah")[:ignore]

    myth_channel = MockActiveRecordChannel.new
    myth_channel.sourceid = 4

    unit.process_channel myth_channel
    assert_equal 0, unit.channel_map.size, "Channel Group should not have been created for ignored channel"
  end

  test "process_myth_channels calls process_channel for each myth channel" do
    unit = MagicMythMapper.new
    def unit.process_channel myth_channel
      @processed_channels = [] if @processed_channels.nil?
      @processed_channels << myth_channel
    end
    def unit.processed_channels
      @processed_channels
    end

    chan1 = "Channel 1"
    chan2 = "Channel 2"
    chan3 = "Channel 3"
    chan4 = "Channel 4"

    unit.process_myth_channels [chan1,chan2,chan3,chan4]

    assert_equal 4, unit.processed_channels.size
  end

  test "lookup_ideal_channel gets an ideal_channel_finder and uses it" do
    unit = MagicMythMapper.new
    def unit.ideal_channel_finder
      {'chan name' =>'Found Channel'}
    end
    assert_equal('Found Channel', unit.lookup_ideal_channel('Chan Name'))
  end

  test "write_changes_to_db tells each channel to write" do
    my_channel_group = MockChannelGroup.new

    unit = MagicMythMapper.new
    def unit.set_channel_map channel_map
      @channel_map = channel_map
    end

    channel_group_1 = MockChannelGroup.new
    channel_group_2 = MockChannelGroup.new
    channel_group_3 = MockChannelGroup.new

    unit.set_channel_map({"name1" => channel_group_1,"name2" => channel_group_2,"name3" => channel_group_3})
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

  test "ideal_channel_finder makes new instance, then reuses it" do
    unit = MagicMythMapper.new
    first_channel_finder = unit.ideal_channel_finder
    second_channel_finder = unit.ideal_channel_finder
    assert_same first_channel_finder, second_channel_finder
  end
end
