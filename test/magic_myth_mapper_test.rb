require File.expand_path('../test_helper.rb', __FILE__)

class MagicMythMapperTest < ActiveSupport::TestCase

  class MockActiveRecordChannel
    attr_accessor :saved, :sourceid, :visible, :icon, :channum, :name, :callsign, :xmltvid, :icon

    def self.find type
      return [MockActiveRecordChannel.new]
    end    
  end 

  test "process_channel registers myth channel using ideal name" do
    ideal_channel_mapper = {'Name' => {:ideal_name => "My Ideal Name", :ignore => false}}
    def ideal_channel_mapper.find(name)
      self[name]
    end
    unit = MagicMythMapper.new(ideal_channel_mapper)

    myth_channel = MockActiveRecordChannel.new
    myth_channel.sourceid = 4
    myth_channel.name = 'Name'

    unit.process_channel myth_channel
    channel_group = unit.channel_map['My Ideal Name']
    assert_not_nil channel_group, "Channel Group not found"
    assert_not_nil channel_group.sources[4], "Source 4 had no channels"
    assert_equal myth_channel, channel_group.sources[4][0]
  end

  test "process_channel records unmatched channels" do
    unit = MagicMythMapper.new

    myth_channel = MockActiveRecordChannel.new
    myth_channel.name = "Non matching channel"

    unit.process_channel myth_channel

    assert_equal 1, unit.unmatched_channel_names.length, "Expected to see one unmatched channel"
    assert_equal "Non matching channel", unit.unmatched_channel_names[0]
  end

  test "process_channel ignores channels with :ignore true" do
    ideal_channel_mapper = {"Name" => {:ideal_name => "My Ideal Name", :ignore => true}}
    def ideal_channel_mapper.find(name)
      self[name]
    end
    unit = MagicMythMapper.new(ideal_channel_mapper)

    myth_channel = MockActiveRecordChannel.new
    myth_channel.sourceid = 4
    myth_channel.name = "Name"

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

end
