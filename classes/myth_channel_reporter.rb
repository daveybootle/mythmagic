class MythChannelReporter
  
  def self.print_report channel_map, unmatched_channel_names 
    print_channel_summary channel_map
    print_channel_numbers channel_map
    print_unmatched_channel_names unmatched_channel_names
  end

  def self.print_channel_summary channel_map
    puts "*** Channel Summary ***"
    channel_map.each do |good_name, channel_group|
      puts "#{channel_group.channum},#{good_name}"
      channel_group.sources.each do |sourceid,channels|
        print "#{channels[0].sourceid}:#{channels.size},"
      end
      puts
    end 
    puts
  end
  
  def self.print_channel_numbers channel_map
    puts "Matched Channels:"
    numbered_channels = channel_map.collect{|good_name, channel_group| [channel_group.channum.to_i, channel_group.name]}.sort
    numbered_channels.each {|numbered_channel| puts "#{numbered_channel[0]} - #{numbered_channel[1]}" }
  end
  
  def self.print_unmatched_channel_names unmatched_channel_names
    puts "Unmatched Channels:"
    unmatched_channel_names.each{ |channel| print "#{channel}, " }
    puts "\n"
  end

end
