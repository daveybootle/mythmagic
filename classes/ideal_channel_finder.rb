class IdealChannelFinder < Hash

  attr_accessor :file_syntax_errors
  
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
        else
          @file_syntax_errors << line unless line.strip == ""
        end
      end
    end
  end

end
