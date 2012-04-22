class VirginChannelFinder < Hash

  def initialize filename
    File.open(filename) do |f|
      while(line = f.gets) do
        parse_line line
      end
    end
  end

  def parse_line line
    split_line = line.split(",")
    if split_line.length == 2 then
      self[split_line[1].downcase.strip] = split_line[0].strip
    end
  end

  def get_channel_number_for name
    channum = self[name.downcase]
    return nil if channum.nil?
    return channum.to_i
  end
end
