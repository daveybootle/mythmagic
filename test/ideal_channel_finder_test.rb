require File.expand_path('../test_helper.rb', __FILE__)

class IdealChannelFinderTest < ActiveSupport::TestCase
  
  test "Should read file data into itself as Hash" do
    unit = IdealChannelFinder.new('test/test_chan_var.csv')

    assert_not_nil unit['BBC Three']
    assert_equal "BBC THREE", (unit['BBC Three'][:ideal_name])

    assert_not_nil unit['BBC THREE']
    assert_equal "BBC3", (unit['BBC THREE'][:short_name])

    assert_not_nil unit['BBC Two Generic']
    assert_equal "south.bbc2.bbc.co.uk", (unit['BBC Two Generic'][:xmltv_id])
    
    assert_not_nil unit['Soft Porn']
    
    assert_not_nil unit['Channel X']
    
    assert_equal 7,unit.length()
  end

  test "Should report unparsable lines" do
    unit = IdealChannelFinder.new('test/test_chan_var.csv')
    assert unit.file_syntax_errors.include?("deliberately stupid line\n")
    assert unit.file_syntax_errors.include?("BBC Two Sud,BBC TWO,BBC2,south.bbc2.bbc.co.uk,nearly correct line\n")
  end

  test "Channel with x instead of XMLTV ID is marked as ignored" do
    unit = IdealChannelFinder.new('test/test_chan_var.csv')
    assert !unit['BBC THREE'][:ignore], "BBC THREE should not be marked as ignored"
    assert unit['Soft Porn'][:ignore], "Soft Porn should be marked as ignored"

    assert !unit['Channel X'][:ignore], "Channel X's XMLTV ID starts with x but should not be ignored"
  end

end

