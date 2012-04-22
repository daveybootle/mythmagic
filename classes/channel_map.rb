class ChannelMap < Hash

  def register_channel ideal_channel, myth_channel
    ideal_name = ideal_channel[:ideal_name]
    self[ideal_name] = create_new_channel_group(ideal_channel) if self[ideal_name].nil?
    self[ideal_name].add_myth_channel(myth_channel)
  end

  def create_new_channel_group ideal_channel
    ChannelGroup.new(ideal_channel[:ideal_name],ideal_channel[:short_name],ideal_channel[:xmltv_id])
  end

  def write_changes_to_db
    self.each do |good_name, channel_group|
      channel_group.write_channels
    end 
  end
  
end
