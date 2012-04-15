require 'pp'

class IdealChannelFinder < Hash

  attr_reader :file_syntax_errors
  
  def initialize mapping_file_name
    @channel_matching_map = {}
    @file_syntax_errors = []
    File.open(mapping_file_name) do |f|
      while(line = f.gets) do
        parse_line line
      end
    end
  end

  def parse_line line
    channel = {}
    line.strip!
    return if line == ""
    line_parts = line.scan(/\[(.*)\],(.*)/)

    if line_parts.length == 0 or line_parts[0].nil? or line_parts[0].size < 2
      @file_syntax_errors << "#{line} - Line invalid"
      return
    end
    
    alt_names = line_parts[0][0].split(",")
    linebits = line_parts[0][1].split(",")
    
    if linebits.length >= 2 then
      alt_names.each do |alt_name|
        channel[:actual_name] = alt_name
        channel[:ideal_name] = linebits[0]
        channel[:short_name] = linebits[1]
        linebits[2] = "" if linebits[2].nil?
        channel[:xmltv_id] = linebits[2].strip
        channel[:ignore] = channel[:xmltv_id][0] == 'x' && channel[:xmltv_id].length == 1 unless channel[:xmltv_id].nil?
        self[alt_name] = channel
      end
    else
      @file_syntax_errors << "#{line} - expected at least 2 ideal parameters but got #{linebits.length}"
    end
  end
end
