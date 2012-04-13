#!/usr/bin/env ruby

require 'active_record'
require 'yaml'

dbconfig = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig['development'])

Dir[File.expand_path('../classes/*.rb', __FILE__)].each{ |file| require file }

mmm = MagicMythMapper.new()
mmm.report

