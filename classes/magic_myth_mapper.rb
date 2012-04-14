class MagicMythMapper

  attr_reader :channel_map, :unmatched_channel_names
  
  def initialize
    @channel_map = {}
    @unmatched_channel_names = []
    
    #fix_all_channels
  end
  
  def process_myth_channels myth_channels
    myth_channels.each { |channel| process_channel(channel) }
  end
  
  def process_channel myth_channel
    ideal_channel = lookup_ideal_channel(myth_channel.name)
    if ideal_channel.nil? then
      @unmatched_channel_names << myth_channel.name
    elsif !ideal_channel[:ignore] then
      register_channel_in_channel_map ideal_channel, myth_channel
    end
  end

  def register_channel_in_channel_map ideal_channel, myth_channel
    ideal_name = ideal_channel[:ideal_name]
    if @channel_map[ideal_name].nil? then
      @channel_map[ideal_name] = ChannelGroup.new(ideal_name,ideal_channel[:short_name],ideal_channel[:xmltv_id])
    end
    @channel_map[ideal_name].add_myth_channel(myth_channel)
  end

  def lookup_ideal_channel channel_name
    @ideal_channel_finder = IdealChannelFinder.new('chan_name_variations.csv') if @ideal_channel_finder.nil?
    @ideal_channel_finder[channel_name]
  end

  def fix_all_channels
    @channel_map.each do |good_name, channel_group|
      channel_group.writechannels
    end 
  end

end 

