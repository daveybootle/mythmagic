class ChannelGroup
  attr_reader :sources, :name, :callsign, :xmltvid, :icon
  
  def initialize channel_name, callsign, xmltvid
    @name = channel_name.strip if channel_name
    @callsign = callsign.strip if callsign
    @xmltvid = xmltvid.strip if xmltvid
    @sources = {}
  end
  
  def add_myth_channel channel
    @sources[channel.sourceid] = [] if @sources[channel.sourceid].nil?
    @sources[channel.sourceid] << channel unless channel.visible == 0
    @icon = channel.icon.strip unless channel.icon.nil? or channel.icon.strip==""
  end
  
  def channum
    first_source_channels = @sources[@sources.keys.sort.first]
    first_source_channums = first_source_channels.collect{|channel| channel.channum.to_i }.select{|f| f >0}
    first_source_channums.sort.first 
  end

  def write_channels
    @sources.each do |sourceid,channels|
      channels.each do |channel| 
        channel.visible=0
        channel.channum=channum
        channel.name=name
        channel.callsign=callsign
        channel.xmltvid=xmltvid
        channel.icon=icon
      end
      channels[0].visible=1
      
#      puts "WRITING: #{sourceid},#{channum},#{name},#{callsign},#{xmltvid},#{icon}"
      channels.each { |channel| channel.save }
    end
  end
end
