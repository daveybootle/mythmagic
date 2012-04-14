require File.expand_path('../test_helper.rb', __FILE__)

class ChannelGroupTest < ActiveSupport::TestCase

  test "Should start with no myth sources" do
    unit = ChannelGroup.new(nil, nil, nil)
    assert_equal 0, unit.sources.length
  end

  test "Should strip and store name, callsign and xmltvid" do
    unit = ChannelGroup.new(" BBC ONE  "," BBC1","one.bbc.co.uk ")
    assert_equal "BBC ONE", unit.name
    assert_equal "BBC1", unit.callsign
    assert_equal "one.bbc.co.uk", unit.xmltvid
  end

  test "Added myth channel available in source map" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")
    channel = MockChannel.new(1,nil)
    unit.add_myth_channel channel

    source_channel_list = unit.sources[1]
    assert_equal 1, source_channel_list.length
    assert_equal channel, source_channel_list.first
  end

  test "Myth channel not added if visible=0" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")
    channel = MockChannel.new(1,nil)
    channel.visible = 0
    unit.add_myth_channel channel

    assert_empty unit.sources[1]
  end

  test "Two added channels should appear in source list" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")
    channel1 = MockChannel.new(1,nil)

    channel2 = MockChannel.new(1,nil)

    unit.add_myth_channel(channel1)
    unit.add_myth_channel(channel2)

    assert_equal 2, unit.sources[1].length
  end

  test "Icon should be available from last added channel" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")
    channel1 = MockChannel.new(1,nil)

    channel2 = MockChannel.new(1,nil)
    channel2.icon = "myicon.png"

    unit.add_myth_channel(channel1)
    unit.add_myth_channel(channel2)

    assert_equal 2, unit.sources[1].length
    assert_equal "myicon.png", unit.icon
  end

  test "Icon should be available from first added channel" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")
    channel1 = MockChannel.new(1,nil)
    channel1.icon = "myicon.png"

    channel2 = MockChannel.new(1,nil)

    unit.add_myth_channel(channel1)
    unit.add_myth_channel(channel2)

    assert_equal 2, unit.sources[1].length
    assert_equal "myicon.png", unit.icon
  end

  test "Empty Icon string should not be added to channel" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")
    channel1 = MockChannel.new(1,nil)
    channel1.icon = "myicon.png"

    channel2 = MockChannel.new(1,nil)
    channel2.icon = ""

    unit.add_myth_channel(channel1)
    unit.add_myth_channel(channel2)

    assert_equal 2, unit.sources[1].length
    assert_equal "myicon.png", unit.icon
  end

  test "Icon strings should be stripped" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")
    channel1 = MockChannel.new(1,nil)
    channel1.icon = "  myicon.png  "

    channel2 = MockChannel.new(1,nil)
    channel2.icon = " "

    unit.add_myth_channel(channel1)
    unit.add_myth_channel(channel2)

    assert_equal 2, unit.sources[1].length
    assert_equal "myicon.png", unit.icon
  end

  test "Lowest channel number taken from numerically first source excluding zero" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")

    channel_without_channum = MockChannel.new(1,nil)

    channel_with_zero_channum = MockChannel.new(1,nil)
    channel_with_zero_channum.channum=0

    channel1 = MockChannel.new(3,nil)
    channel1.channum=1234

    channel2 = MockChannel.new(1,nil)
    channel2.channum=32

    channel3 = MockChannel.new(1,nil)
    channel3.sourceid=1
    channel3.channum=4

    unit.add_myth_channel(channel_without_channum)
    unit.add_myth_channel(channel_with_zero_channum)
    unit.add_myth_channel(channel1)
    unit.add_myth_channel(channel2)
    unit.add_myth_channel(channel3)

    assert_equal 4, unit.channum
  end

  test "writeChannels should save each channel with group's details" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")
    channel1 = MockChannel.new(1, 5)
    channel2 = MockChannel.new(2, 1345)
    channel3 = MockChannel.new(2, 300)

    channel2.icon = "myicon.png"

    unit.add_myth_channel(channel1)
    unit.add_myth_channel(channel2)
    unit.add_myth_channel(channel3)

    unit.write_channels

    assert channel1.saved, "Should have saved channel 1"
    assert channel2.saved, "Should have saved channel 2"
    assert channel3.saved, "Should have saved channel 3"

    assert_equal 5, channel1.channum
    assert_equal 5, channel2.channum
    assert_equal 5, channel3.channum

    assert_equal "BBC ONE", channel1.name
    assert_equal "BBC ONE", channel2.name
    assert_equal "BBC ONE", channel3.name

    assert_equal "BBC1", channel1.callsign
    assert_equal "BBC1", channel2.callsign
    assert_equal "BBC1", channel3.callsign

    assert_equal "one.bbc.co.uk", channel1.xmltvid
    assert_equal "one.bbc.co.uk", channel2.xmltvid
    assert_equal "one.bbc.co.uk", channel3.xmltvid

    assert_equal "myicon.png", channel1.icon
    assert_equal "myicon.png", channel2.icon
    assert_equal "myicon.png", channel3.icon
  end

  test "should only be one visible channel per source" do
    unit = ChannelGroup.new("BBC ONE","BBC1","one.bbc.co.uk")
    channel1 = MockChannel.new(1, 5)
    channel2 = MockChannel.new(2, 1345)
    channel3 = MockChannel.new(2, 300)

    unit.add_myth_channel(channel1)
    unit.add_myth_channel(channel2)
    unit.add_myth_channel(channel3)

    unit.write_channels

    assert_equal 1, channel1.visible, "Channel 1 should be visible"
    assert_equal 1, channel2.visible, "Channel 2 should be visible"
    assert_equal 0, channel3.visible, "Channel 3 should be invisible"
  end

  class MockChannel
    attr_accessor :saved, :sourceid, :visible, :icon, :channum, :name, :callsign, :xmltvid, :icon
    def initialize(sourceid, channum)
      @saved=false
      @sourceid = sourceid
      @channum = channum
    end

    def save
      @saved=true
    end
  end
end
