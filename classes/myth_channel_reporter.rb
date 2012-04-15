
require 'pp'

class MythChannelReporter
  
  def self.print_report channel_map, unmatched_channel_names 
    print_channel_group_summary channel_map
    print_unmatched_channel_names unmatched_channel_names
  end

  def self.print_channel_group_summary channel_map
    puts "*** Channel Summary ***"

    sources = channel_map.collect{ |good_name, channel_group| channel_group.sources.collect{|sourceid,channels| sourceid } }.flatten.uniq.sort

    chan_name_width = channel_map.collect{ |good_name, channel_group| good_name.length }.max + 1
    chan_num_width = channel_map.collect{ |good_name, channel_group| channel_group.channum.to_s.length }.max + 1
    icon_width = channel_map.collect{ |good_name, channel_group| channel_group.icon.to_s.length }.max + 1
    xmltv_width = channel_map.collect{ |good_name, channel_group| channel_group.xmltvid.to_s.length }.max + 1

    source_width = 6

    print " "*(chan_name_width+chan_num_width)
    puts "Channel Count".center(source_width*sources.length)
    print "Chan".ljust(chan_num_width)
    print "Name".ljust(chan_name_width)
    sources.each {|source| print "Src:#{source}".ljust(source_width) }
    print "Icon".ljust(icon_width)
    print "XMLTV ID".ljust(xmltv_width)
    puts

    lines_without_channum = []
    lines_with_channum = {}
 
    channel_map.each do |good_name, channel_group|
      output_string = ""
      output_string << channel_group.channum.to_s.ljust(chan_num_width)
      output_string << good_name.ljust(chan_name_width)
      sources.each do |sourceid|
        source = channel_group.sources[sourceid]
        if source.nil?
          num_sources = " "
        else
          num_sources = source.length.to_s
        end
        output_string << num_sources.ljust(source_width)
      end
      output_string << channel_group.icon.to_s.ljust(icon_width)
      output_string << channel_group.xmltvid.to_s.ljust(xmltv_width)

      if channel_group.channum.nil?
        lines_without_channum << output_string
      else
        lines_with_channum[channel_group.channum] = output_string
      end
    end 
    lines_with_channum.keys.sort.each_with_index do |key, index|
      if(index.modulo(2)==1) then
        print "\033[1;48;5;22m"
      else
        print "\033[1;48;5;28m"
      end

      print lines_with_channum[key]
      puts "\033[0m"
    end

    lines_without_channum.each_with_index do |line,index|
      if(index.modulo(2)==1) then
        print "\033[1;48;5;52m"
      else
        print "\033[1;48;5;88m"
      end

      print line
      puts "\033[0m"
    end

    puts 
  end
  
  def self.print_unmatched_channel_names unmatched_channel_names
    puts "#{unmatched_channel_names.size} Unmatched Channels:"
    unmatched_channel_names.each{ |channel| print "#{channel}, " }
    puts "\n"
  end

end
