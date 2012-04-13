class MagicMythMapper
 
  def initialize
    channel_matcher = ChannelMatcher.new('chan_name_variations.csv')
    
    @unmatched_channels = []
    @channel_map = create_channel_map(channel_matcher, @unmatched_channels)
    #fix_all_channels channel_map
  end

  def report
    print_channel_summary @channel_map
    print_unmatched_channels @unmatched_channels
    print_channel_numbers @channel_map
  end
  
  def create_channel_map(channel_matcher, unmatched_channels)
    channel_map = {}
    channels = Channel.find(:all)
    channels.each do |myth_channel|
      found_channel = channel_matcher[myth_channel.name]
      if found_channel.nil? then
        unmatched_channels << myth_channel.name
      elsif found_channel[:xmltv_id][0] != 120 then
        ideal_name = found_channel[:ideal_name]
        if channel_map[ideal_name].nil? then
          cg = ChannelGroup.new(ideal_name,found_channel[:short_name],found_channel[:xmltv_id])
          channel_map[ideal_name] = cg
        end
        channel_map[ideal_name].add_myth_channel(myth_channel)
      end
    end
    channel_map
  end

  
  def fix_all_channels channel_map
    channel_map.each do |good_name, channel_group|
      channel_group.writechannels
    end 
  end

  def print_channel_summary channel_map
    puts "Channel Summary:"
    channel_map.each do |good_name, channel_group|
      if channel_group.channum == "" then
        puts "#{channel_group.channum},#{good_name}"
        channel_group.sources.each do |sourceid,channels|
          print "#{channels[0].sourceid}:#{channels.size},"
        end
        puts
      end
    end 
    puts
  end
  
  def print_unmatched_channels unmatched_channels
    puts "Unmatched Channels:"
    unmatched_channels.each{ |channel| print "#{channel}, " }
    puts "\n"
  end

  def print_channel_numbers channel_map
    numbered_channels = channel_map.collect{|good_name, channel_group| [channel_group.channum.to_i, channel_group.name]}.sort
    numbered_channels.each {|numbered_channel| puts "#{numbered_channel[0]} - #{numbered_channel[1]}" }
  end

end 
  
#channels = Channel.find(:all, {:conditions => {:sourceid => 8, :visible => 1}})
#regexp = Regexp.new(/[A-Za-z]/)
#non_alpha_chans = channels.select{|c| c.callsign.match(regexp).nil?}
#puts non_alpha_chans.collect{|c| c.callsign}
#xmltv_missing = channels.select{|c| c.xmltvid == "" || c.xmltvid.nil?}

#xmltv_missing.each do |c|
# puts c.callsign + "," + c.name + "," + c.xmltvid
# c.callsign = c.name
# c.visible = 0
# c.save
#end

#File.open("/home/mythtv/.xmltv/supplement/tv_grab_uk_rt/channel_ids") { |f|
# while(line = f.gets) do
#   linebits = line.split("|")
#   xmltvid = linebits[0]
#   name = linebits[2]
#   channels = Channel.find(:all, {:conditions => {:sourceid => 8, :name => name}})
#   if(channels.size > 0) then
#     puts "#{name} found #{channels.size} times... enabling first"
#     sel_chan = channels.first
#     sel_chan.visible=1
#     sel_chan.xmltvid = xmltvid
##      sel_chan.save
#   else
#     puts "#{name} not found"
#   end
# end
#}
#hd.scifi.movies.sky.com|2161|Sky Movies Sci-Fi/Horror HD|http://www.lyngsat-logo.com/logo/tv/ss/sky_movies_scifi_horror.jpg|||HDTV
