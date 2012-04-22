class VirginChannelFinder < Hash

  def initialize filename, ideal_channel_finder = nil
    @ideal_channel_finder = ideal_channel_finder
    File.open(filename) do |f|
      while(line = f.gets) do
        parse_line line
      end
    end
  end

  def get_channel_number_for name
    channel_number = self[name.downcase]
    unless channel_number.nil?
      return channel_number.to_i 
    end
  end

  private

  def parse_line line
    split_line = line.split(",")
    if split_line.length == 2 then
      virgin_name = split_line[1].downcase.strip
      ideal_name = get_ideal_name_from(virgin_name)
      self[ideal_name] = split_line[0].strip
    end
  end

  def get_ideal_name_from virgin_name
    if @ideal_channel_finder then
      ideal_channel = @ideal_channel_finder.find(virgin_name)
      return ideal_channel[:ideal_name].downcase unless ideal_channel.nil?
    end
    return virgin_name
  end
end
