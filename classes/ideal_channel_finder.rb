class IdealChannelFinder < Hash

  attr_reader :file_syntax_errors
  
  def initialize mapping_file_name
    @channel_matching_map = {}
    @file_syntax_errors = []
    File.open(mapping_file_name) do |f|
      while(line = f.gets) do
        channel = {}
        linebits = line.split(",")

        if linebits.length == 4 then
          channel[:actual_name] = linebits[0]
          channel[:ideal_name] = linebits[1]
          channel[:short_name] = linebits[2]
          channel[:xmltv_id] = linebits[3].strip
          self[linebits[0]] = channel
          channel[:ignore] = channel[:xmltv_id][0] == 'x' && channel[:xmltv_id].length == 1 
        else
          @file_syntax_errors << line unless line.strip == ""
        end
      end
    end
  end

end
