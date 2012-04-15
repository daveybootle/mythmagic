require File.expand_path('../test_helper.rb', __FILE__)

class IdealChannelFinderTest < ActiveSupport::TestCase
  
  test "Should read file data into itself as Hash with lower case key" do
    unit = IdealChannelFinder.new('test/test_chan_var.csv')
    assert_equal 2, unit.file_syntax_errors.size

    assert_not_nil unit['bbc three']
    assert_equal "BBC THREE", (unit['bbc three'][:ideal_name])

    assert_not_nil unit['bbc three']
    assert_equal "BBC3", (unit['bbc three'][:short_name])

    assert_not_nil unit['bbc two generic']
    assert_equal "", (unit['bbc two generic'][:xmltv_id])
    
    assert_not_nil unit['soft porn']
    
    assert_not_nil unit['channel x']
   
    assert_equal 6,unit.length()
  end

  test "Should report unparsable lines" do
    unit = IdealChannelFinder.new('test/test_chan_var.csv')
    assert_equal "deliberately stupid line - Line invalid", unit.file_syntax_errors[0]
    assert_equal "[BBC Two Sud],Nearly good, - expected at least 2 ideal parameters but got 1", unit.file_syntax_errors[1]
  end

  test "Channel with x instead of XMLTV ID is marked as ignored" do
    unit = IdealChannelFinder.new('test/test_chan_var.csv')
    assert unit['soft porn'][:ignore], "Soft Porn should be marked as ignored"
  end

  test "Chanels without x in XMLTV ID or with more than just x should not be marked as ignored" do
    unit = IdealChannelFinder.new('test/test_chan_var.csv')
    assert !unit['bbc three'][:ignore], "BBC THREE should not be marked as ignored"
    assert !unit['channel x'][:ignore], "Channel X's XMLTV ID starts with x but should not be ignored"
  end
    
end

