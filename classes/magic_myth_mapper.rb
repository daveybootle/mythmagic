class MagicMythMapper

  attr_reader :channel_map, :unmatched_channel_names
  
  def initialize
    @channel_map = ChannelMap.new
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
      @channel_map.register_channel ideal_channel, myth_channel
    end
  end

  def ideal_channel_finder
    if @ideal_channel_finder.nil?
      @ideal_channel_finder = IdealChannelFinder.new(File.expand_path('../../chan_name_variations.csv',__FILE__)) 
      puts @ideal_channel_finder.file_syntax_errors
    end
    @ideal_channel_finder
  end

  def lookup_ideal_channel channel_name
    ideal_channel_finder[channel_name.downcase]
  end

end 

