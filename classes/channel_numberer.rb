class ChannelNumberer

  def initialize channel_finder = nil
    @channel_finder = channel_finder
  end

  def number(input_channel_map)
    output_channel_map = {}
    input_channel_map.sort.each do |key, channel_map_channel_group|
      channel_group = channel_map_channel_group
      channum = @channel_finder.get_channel_number_for(channel_group.name) if @channel_finder
      if channum.nil?
        channum = find_next_free_channum(output_channel_map)
      else
        clear_way_for_channel(output_channel_map, channum)
      end

      channel_group.channum=channum
      output_channel_map[channum] = channel_group
    end
    output_channel_map
  end

  def clear_way_for_channel(output_channel_map, channum)
    if(!output_channel_map[channum].nil?)
      alt_channum = find_next_free_channum(output_channel_map)
      move_channel(output_channel_map,channum,alt_channum)
    end
  end
  
  def find_next_free_channum channel_map
    try_channel=1000
    while !channel_map[try_channel].nil? do
      try_channel += 1
    end
    try_channel
  end

  def move_channel channel_map, old_channum, new_channum
    channel_map[new_channum] = channel_map[old_channum]
    channel_map[new_channum].channum = new_channum
    channel_map[old_channum] = nil
  end
end

