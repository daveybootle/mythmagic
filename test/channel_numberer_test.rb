require File.expand_path('../test_helper.rb', __FILE__)

class ChannelNumbererTest < ActiveSupport::TestCase

  test "number adds channels in alphabetical order" do
    unit = ChannelNumberer.new

    chan1 = ChannelGroup.new("Channel 1", "Chan1", "chan1.xmltv.com")
    chan2 = ChannelGroup.new("Channel 2", "Chan2", "chan2.xmltv.com")
    chan3 = ChannelGroup.new("Channel 3", "Chan3", "chan3.xmltv.com")

    input_map = {"Channel 3" => chan3, "Channel 2" => chan2, "Channel 1" => chan1}

    output_map = unit.number(input_map)

    assert_equal chan1, output_map[1000]
    assert_equal 1000, output_map[1000].channum

    assert_equal chan2, output_map[1001]
    assert_equal 1001, output_map[1001].channum

    assert_equal chan3, output_map[1002]
    assert_equal 1002, output_map[1002].channum
    
  end

  test "number delegates to channel finder if supplied" do

    channel_finder = {"Channel 1" => 101, "Channel 2" => 102}
    def channel_finder.get_channel_number_for(name)
      self[name]
    end

    unit = ChannelNumberer.new(channel_finder)

    chan1 = ChannelGroup.new("Channel 1", "Chan1", "chan1.xmltv.com")
    chan2 = ChannelGroup.new("Channel 2", "Chan2", "chan2.xmltv.com")
    chan3 = ChannelGroup.new("Channel 3", "Chan3", "chan3.xmltv.com")

    input_map = {"Channel 3" => chan3, "Channel 2" => chan2, "Channel 1" => chan1}

    output_map = unit.number(input_map)

    assert_equal chan1, output_map[101]
    assert_equal 101, output_map[101].channum

    assert_equal chan2, output_map[102]
    assert_equal 102, output_map[102].channum
    
    assert_equal chan3, output_map[1000]
    assert_equal 1000, output_map[1000].channum

  end

  test "when channel from channel_finder asks for an already allocated channel, that channel gets moved to next available channum" do
    channel_finder = {"Channel 2 Finder Channel" => 1000}
    def channel_finder.get_channel_number_for(name)
      self[name]
    end

    unit = ChannelNumberer.new(channel_finder)

    chan1 = ChannelGroup.new("Channel 1 To Be Moved", "Chan1", "chan1.xmltv.com")  # would have been 1000, but should be moved to 1001
    chan2 = ChannelGroup.new("Channel 2 Finder Channel", "Chan2", "chan_finder_chan.xmltv.com") #would have been 1001 but channel_finder says 1000

    input_map = {chan1.name => chan1, chan2.name => chan2}

    output_map = unit.number(input_map)

    assert_equal 1000, chan2.channum, "'Channel 2 Finder Channel' should have overridden 'Channel 1 To Be Moved'"
    assert_not_equal 1000, chan1.channum, "'Channel 1 To Be Moved' should have been moved out of the way of 'Channel 2 Finder Channel'"
    assert_equal 1001, chan1.channum, "'Channel 1 To Be Moved' should have been moved to next available channel (1001)"
  end

  test "find_next_free_channum finds the next free chan num" do
    unit = ChannelNumberer.new
    existing_channel_map = {1000 => "zero", 1001 => "one", 1002 => "two", 1003 => "three"}
    assert_equal 1004, unit.find_next_free_channum(existing_channel_map)
  end

end
