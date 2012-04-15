class MagicMythMapper

  attr_reader :channel_map, :unmatched_channel_names
  
  def initialize
    @channel_map = {}
    @unmatched_channel_names = []
    
    #write_changes_to_db
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
    @channel_map[ideal_name] = create_new_channel_group(ideal_channel) if @channel_map[ideal_name].nil?
    @channel_map[ideal_name].add_myth_channel(myth_channel)
  end

  def create_new_channel_group ideal_channel
    ChannelGroup.new(ideal_channel[:ideal_name],ideal_channel[:short_name],ideal_channel[:xmltv_id])
  end

  def ideal_channel_finder
    if @ideal_channel_finder.nil?
      @ideal_channel_finder = IdealChannelFinder.new('chan_name_variations.csv') 
      puts @ideal_channel_finder.file_syntax_errors
    end
    @ideal_channel_finder
  end

  def lookup_ideal_channel channel_name
    ideal_channel_finder[channel_name]
  end

  def write_changes_to_db
    @channel_map.each do |good_name, channel_group|
      channel_group.writechannels
    end 
  end

end 

