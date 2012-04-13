class Channel < ActiveRecord::Base
  
  self.primary_key = 'chanid'
  self.table_name = 'channel'

end
