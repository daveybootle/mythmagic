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
