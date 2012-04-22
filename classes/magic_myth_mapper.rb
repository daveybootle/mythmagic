class MagicMythMapper

  attr_reader :channel_map, :unmatched_channel_names
  
  def initialize ideal_channel_finder = nil
    @ideal_channel_finder = ideal_channel_finder
    @channel_map = ChannelMap.new
    @unmatched_channel_names = []
    
  end
 
  def write_changes_to_db
    @channel_map.write_changes_to_db
  end

  def process_myth_channels myth_channels
    myth_channels.each { |channel| process_channel(channel) }
  end
  
  def process_channel myth_channel
    ideal_channel = @ideal_channel_finder.find(myth_channel.name) if @ideal_channel_finder
    if ideal_channel.nil? then
      @unmatched_channel_names << myth_channel.name
    elsif !ideal_channel[:ignore] then
      @channel_map.register_channel ideal_channel, myth_channel
    end
  end

end 

