require File.expand_path('../test_helper.rb', __FILE__)

class VirginChannelFinderTest < ActiveSupport::TestCase

  test "reads file and provides as map" do
    unit = VirginChannelFinder.new('test/test_virgin_guide.txt')
    assert_equal "104", unit.get_channel_number_for("channel 4")
    assert_equal "102", unit.get_channel_number_for("BBC Two")
  end
end
