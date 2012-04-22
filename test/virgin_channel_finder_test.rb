require File.expand_path('../test_helper.rb', __FILE__)

class VirginChannelFinderTest < ActiveSupport::TestCase
  
  test "reads file and provides as map based on virgin name if no channel_matcher provided" do
    unit = VirginChannelFinder.new(File.expand_path('../test_virgin_guide.txt',__FILE__), nil)
    assert_equal 104, unit.get_channel_number_for("channel 4")
    assert_equal 102, unit.get_channel_number_for("BBC Two")
    assert_nil unit.get_channel_number_for("foobar")
  end

  test "provides map based on channel_matcher if provided" do
    ideal_channel_finder = {"bbc three" => {:ideal_name => 'Sexy Name'}}
    def ideal_channel_finder.find(name)
      self[name]
    end
    unit = VirginChannelFinder.new(File.expand_path('../test_virgin_guide.txt',__FILE__), ideal_channel_finder)
    assert_equal 102, unit.get_channel_number_for("BBC Two")
    assert_equal 106, unit.get_channel_number_for("sexy name")
  end

end
