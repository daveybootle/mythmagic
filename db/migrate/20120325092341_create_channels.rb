class CreateChannels < ActiveRecord::Migration
  def up
    create_table(:channel, :primary_key => 'chanid' ) do |t|
      t.string :channum
      t.string :freqid
      t.integer :sourceid
      t.string :callsign
      t.string :name
      t.string :icon
      t.integer :finetune
      t.string :videofilters
      t.string :xmltvid
      t.integer :recpriority
      t.integer :contrast
      t.integer :brightness
      t.integer :colour
      t.integer :hue
      t.string :tvformat
      t.integer :visible
      t.string :outputfilters
      t.integer :useonairguide
      t.integer :mplexid
      t.integer :serviceid
      t.integer :atsc_major_chan
      t.integer :atsc_minor_chan
      t.date :last_record
      t.string :default_authority
      t.integer :commmethod
    end
  end
  def down
    drop_table :channel
  end
end
