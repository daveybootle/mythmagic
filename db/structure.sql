CREATE TABLE `albums` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` char(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=918 DEFAULT CHARSET=latin1;

CREATE TABLE `archiveitems` (
  `intid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` set('Recording','Video','File') CHARACTER SET latin1 DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `subtitle` varchar(128) DEFAULT NULL,
  `description` text,
  `startdate` varchar(30) DEFAULT NULL,
  `starttime` varchar(30) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `filename` text NOT NULL,
  `hascutlist` tinyint(1) NOT NULL DEFAULT '0',
  `cutlist` text,
  `duration` int(10) unsigned NOT NULL DEFAULT '0',
  `cutduration` int(10) unsigned NOT NULL DEFAULT '0',
  `videowidth` int(10) unsigned NOT NULL DEFAULT '0',
  `videoheight` int(10) unsigned NOT NULL DEFAULT '0',
  `filecodec` varchar(50) NOT NULL DEFAULT '',
  `videocodec` varchar(50) NOT NULL DEFAULT '',
  `encoderprofile` varchar(50) NOT NULL DEFAULT 'NONE',
  PRIMARY KEY (`intid`),
  KEY `title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `artists` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` char(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1010 DEFAULT CHARSET=latin1;

CREATE TABLE `callsignnetworkmap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `callsign` varchar(20) NOT NULL DEFAULT '',
  `network` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `callsign` (`callsign`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `capturecard` (
  `cardid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `videodevice` varchar(128) DEFAULT NULL,
  `audiodevice` varchar(128) DEFAULT NULL,
  `vbidevice` varchar(128) DEFAULT NULL,
  `cardtype` varchar(32) DEFAULT 'V4L',
  `defaultinput` varchar(32) DEFAULT 'Television',
  `audioratelimit` int(11) DEFAULT NULL,
  `hostname` varchar(64) DEFAULT NULL,
  `dvb_swfilter` int(11) DEFAULT '0',
  `dvb_sat_type` int(11) NOT NULL DEFAULT '0',
  `dvb_wait_for_seqstart` int(11) NOT NULL DEFAULT '1',
  `skipbtaudio` tinyint(1) DEFAULT '0',
  `dvb_on_demand` tinyint(4) NOT NULL DEFAULT '0',
  `dvb_diseqc_type` smallint(6) DEFAULT NULL,
  `firewire_speed` int(10) unsigned NOT NULL DEFAULT '0',
  `firewire_model` varchar(32) DEFAULT NULL,
  `firewire_connection` int(10) unsigned NOT NULL DEFAULT '0',
  `signal_timeout` int(11) NOT NULL DEFAULT '1000',
  `channel_timeout` int(11) NOT NULL DEFAULT '3000',
  `dvb_tuning_delay` int(10) unsigned NOT NULL DEFAULT '0',
  `contrast` int(11) NOT NULL DEFAULT '0',
  `brightness` int(11) NOT NULL DEFAULT '0',
  `colour` int(11) NOT NULL DEFAULT '0',
  `hue` int(11) NOT NULL DEFAULT '0',
  `diseqcid` int(10) unsigned DEFAULT NULL,
  `dvb_eitscan` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cardid`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE `cardinput` (
  `cardinputid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cardid` int(10) unsigned NOT NULL DEFAULT '0',
  `sourceid` int(10) unsigned NOT NULL DEFAULT '0',
  `inputname` varchar(32) NOT NULL DEFAULT '',
  `externalcommand` varchar(128) DEFAULT NULL,
  `shareable` char(1) DEFAULT 'N',
  `tunechan` varchar(10) DEFAULT NULL,
  `startchan` varchar(10) DEFAULT NULL,
  `displayname` varchar(64) NOT NULL DEFAULT '',
  `dishnet_eit` tinyint(1) NOT NULL DEFAULT '0',
  `recpriority` int(11) NOT NULL DEFAULT '0',
  `quicktune` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cardinputid`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE `channel` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `channum` varchar(10) NOT NULL DEFAULT '',
  `freqid` varchar(10) DEFAULT NULL,
  `sourceid` int(10) unsigned DEFAULT NULL,
  `callsign` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  `icon` varchar(255) NOT NULL DEFAULT 'none',
  `finetune` int(11) DEFAULT NULL,
  `videofilters` varchar(255) NOT NULL DEFAULT '',
  `xmltvid` varchar(64) NOT NULL DEFAULT '',
  `recpriority` int(10) NOT NULL DEFAULT '0',
  `contrast` int(11) DEFAULT '32768',
  `brightness` int(11) DEFAULT '32768',
  `colour` int(11) DEFAULT '32768',
  `hue` int(11) DEFAULT '32768',
  `tvformat` varchar(10) NOT NULL DEFAULT 'Default',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `outputfilters` varchar(255) NOT NULL DEFAULT '',
  `useonairguide` tinyint(1) DEFAULT '0',
  `mplexid` smallint(6) DEFAULT NULL,
  `serviceid` mediumint(8) unsigned DEFAULT NULL,
  `atsc_major_chan` int(10) unsigned NOT NULL DEFAULT '0',
  `atsc_minor_chan` int(10) unsigned NOT NULL DEFAULT '0',
  `last_record` datetime NOT NULL,
  `default_authority` varchar(32) NOT NULL DEFAULT '',
  `commmethod` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`chanid`),
  KEY `channel_src` (`channum`,`sourceid`),
  KEY `sourceid` (`sourceid`,`xmltvid`,`chanid`),
  KEY `visible` (`visible`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `channelgroup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `chanid` int(11) unsigned NOT NULL DEFAULT '0',
  `grpid` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

CREATE TABLE `channelgroupnames` (
  `grpid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`grpid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `channelscan` (
  `scanid` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `cardid` int(3) unsigned NOT NULL,
  `sourceid` int(3) unsigned NOT NULL,
  `processed` tinyint(1) unsigned NOT NULL,
  `scandate` datetime NOT NULL,
  PRIMARY KEY (`scanid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE `channelscan_channel` (
  `transportid` int(6) unsigned NOT NULL,
  `scanid` int(3) unsigned NOT NULL,
  `mplex_id` smallint(6) NOT NULL,
  `source_id` int(3) unsigned NOT NULL,
  `channel_id` int(3) unsigned NOT NULL DEFAULT '0',
  `callsign` varchar(20) NOT NULL DEFAULT '',
  `service_name` varchar(64) NOT NULL DEFAULT '',
  `chan_num` varchar(10) NOT NULL DEFAULT '',
  `service_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `atsc_major_channel` int(4) unsigned NOT NULL DEFAULT '0',
  `atsc_minor_channel` int(4) unsigned NOT NULL DEFAULT '0',
  `use_on_air_guide` tinyint(1) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `hidden_in_guide` tinyint(1) NOT NULL DEFAULT '0',
  `freqid` varchar(10) NOT NULL DEFAULT '',
  `icon` varchar(255) NOT NULL DEFAULT '',
  `tvformat` varchar(10) NOT NULL DEFAULT 'Default',
  `xmltvid` varchar(64) NOT NULL DEFAULT '',
  `pat_tsid` int(5) unsigned NOT NULL DEFAULT '0',
  `vct_tsid` int(5) unsigned NOT NULL DEFAULT '0',
  `vct_chan_tsid` int(5) unsigned NOT NULL DEFAULT '0',
  `sdt_tsid` int(5) unsigned NOT NULL DEFAULT '0',
  `orig_netid` int(5) unsigned NOT NULL DEFAULT '0',
  `netid` int(5) unsigned NOT NULL DEFAULT '0',
  `si_standard` varchar(10) NOT NULL,
  `in_channels_conf` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `in_pat` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `in_pmt` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `in_vct` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `in_nit` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `in_sdt` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_encrypted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_data_service` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_audio_service` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_opencable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `could_be_opencable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `decryption_status` smallint(2) unsigned NOT NULL DEFAULT '0',
  `default_authority` varchar(32) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `channelscan_dtv_multiplex` (
  `transportid` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `scanid` int(3) unsigned NOT NULL,
  `mplexid` smallint(6) unsigned NOT NULL,
  `frequency` bigint(12) unsigned NOT NULL,
  `inversion` char(1) NOT NULL DEFAULT 'a',
  `symbolrate` bigint(12) unsigned NOT NULL DEFAULT '0',
  `fec` varchar(10) NOT NULL DEFAULT 'auto',
  `polarity` char(1) NOT NULL DEFAULT '',
  `hp_code_rate` varchar(10) NOT NULL DEFAULT 'auto',
  `mod_sys` varchar(10) DEFAULT NULL,
  `rolloff` varchar(4) DEFAULT NULL,
  `lp_code_rate` varchar(10) NOT NULL DEFAULT 'auto',
  `modulation` varchar(10) NOT NULL DEFAULT 'auto',
  `transmission_mode` char(1) NOT NULL DEFAULT 'a',
  `guard_interval` varchar(10) NOT NULL DEFAULT 'auto',
  `hierarchy` varchar(10) NOT NULL DEFAULT 'auto',
  `bandwidth` char(1) NOT NULL DEFAULT 'a',
  `sistandard` varchar(10) NOT NULL,
  `tuner_type` smallint(2) unsigned NOT NULL,
  `default_authority` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`transportid`)
) ENGINE=MyISAM AUTO_INCREMENT=491 DEFAULT CHARSET=utf8;

CREATE TABLE `codecparams` (
  `profile` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `value` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`profile`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `credits` (
  `person` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `role` set('actor','director','producer','executive_producer','writer','guest_star','host','adapter','presenter','commentator','guest') CHARACTER SET latin1 NOT NULL DEFAULT '',
  UNIQUE KEY `chanid` (`chanid`,`starttime`,`person`,`role`),
  KEY `person` (`person`,`role`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `customexample` (
  `rulename` varchar(64) NOT NULL,
  `fromclause` text NOT NULL,
  `whereclause` text NOT NULL,
  `search` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rulename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `diseqc_config` (
  `cardinputid` int(10) unsigned NOT NULL,
  `diseqcid` int(10) unsigned NOT NULL,
  `value` varchar(16) NOT NULL DEFAULT '',
  KEY `id` (`cardinputid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `diseqc_tree` (
  `diseqcid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parentid` int(10) unsigned DEFAULT NULL,
  `ordinal` tinyint(3) unsigned NOT NULL,
  `type` varchar(16) NOT NULL DEFAULT '',
  `subtype` varchar(16) NOT NULL DEFAULT '',
  `description` varchar(32) NOT NULL DEFAULT '',
  `switch_ports` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rotor_hi_speed` float NOT NULL DEFAULT '0',
  `rotor_lo_speed` float NOT NULL DEFAULT '0',
  `rotor_positions` varchar(255) NOT NULL DEFAULT '',
  `lnb_lof_switch` int(10) NOT NULL DEFAULT '0',
  `lnb_lof_hi` int(10) NOT NULL DEFAULT '0',
  `lnb_lof_lo` int(10) NOT NULL DEFAULT '0',
  `cmd_repeat` int(11) NOT NULL DEFAULT '1',
  `lnb_pol_inv` tinyint(4) NOT NULL DEFAULT '0',
  `address` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`diseqcid`),
  KEY `parentid` (`parentid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `displayprofilegroups` (
  `name` varchar(128) NOT NULL,
  `hostname` varchar(64) NOT NULL,
  `profilegroupid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`name`,`hostname`),
  UNIQUE KEY `profilegroupid` (`profilegroupid`)
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

CREATE TABLE `displayprofiles` (
  `profilegroupid` int(10) unsigned NOT NULL,
  `profileid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(128) NOT NULL,
  `data` varchar(255) NOT NULL DEFAULT '',
  KEY `profilegroupid` (`profilegroupid`),
  KEY `profileid` (`profileid`,`value`),
  KEY `profileid_2` (`profileid`)
) ENGINE=MyISAM AUTO_INCREMENT=370 DEFAULT CHARSET=utf8;

CREATE TABLE `dtv_multiplex` (
  `mplexid` smallint(6) NOT NULL AUTO_INCREMENT,
  `sourceid` smallint(6) DEFAULT NULL,
  `transportid` int(11) DEFAULT NULL,
  `networkid` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `inversion` char(1) DEFAULT 'a',
  `symbolrate` int(11) DEFAULT NULL,
  `fec` varchar(10) DEFAULT 'auto',
  `polarity` char(1) DEFAULT NULL,
  `modulation` varchar(10) DEFAULT 'auto',
  `bandwidth` char(1) DEFAULT 'a',
  `lp_code_rate` varchar(10) DEFAULT 'auto',
  `transmission_mode` char(1) DEFAULT 'a',
  `guard_interval` varchar(10) DEFAULT 'auto',
  `visible` smallint(1) NOT NULL DEFAULT '0',
  `constellation` varchar(10) DEFAULT 'auto',
  `hierarchy` varchar(10) DEFAULT 'auto',
  `hp_code_rate` varchar(10) DEFAULT 'auto',
  `mod_sys` varchar(10) DEFAULT NULL,
  `rolloff` varchar(4) DEFAULT NULL,
  `sistandard` varchar(10) DEFAULT 'dvb',
  `serviceversion` smallint(6) DEFAULT '33',
  `updatetimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `default_authority` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`mplexid`)
) ENGINE=MyISAM AUTO_INCREMENT=451 DEFAULT CHARSET=utf8;

CREATE TABLE `dtv_privatetypes` (
  `sitype` varchar(4) NOT NULL DEFAULT '',
  `networkid` int(11) NOT NULL DEFAULT '0',
  `private_type` varchar(20) NOT NULL DEFAULT '',
  `private_value` varchar(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `dvdbookmark` (
  `serialid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) DEFAULT NULL,
  `title` smallint(6) NOT NULL DEFAULT '0',
  `audionum` tinyint(4) NOT NULL DEFAULT '-1',
  `subtitlenum` tinyint(4) NOT NULL DEFAULT '-1',
  `framenum` bigint(20) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`serialid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `dvdinput` (
  `intid` int(10) unsigned NOT NULL DEFAULT '0',
  `hsize` int(10) unsigned DEFAULT NULL,
  `vsize` int(10) unsigned DEFAULT NULL,
  `ar_num` int(10) unsigned DEFAULT NULL,
  `ar_denom` int(10) unsigned DEFAULT NULL,
  `fr_code` int(10) unsigned DEFAULT NULL,
  `letterbox` tinyint(1) DEFAULT NULL,
  `v_format` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`intid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `dvdtranscode` (
  `intid` int(11) NOT NULL AUTO_INCREMENT,
  `input` int(10) unsigned DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `sync_mode` int(10) unsigned DEFAULT NULL,
  `use_yv12` tinyint(1) DEFAULT NULL,
  `cliptop` int(11) DEFAULT NULL,
  `clipbottom` int(11) DEFAULT NULL,
  `clipleft` int(11) DEFAULT NULL,
  `clipright` int(11) DEFAULT NULL,
  `f_resize_h` int(11) DEFAULT NULL,
  `f_resize_w` int(11) DEFAULT NULL,
  `hq_resize_h` int(11) DEFAULT NULL,
  `hq_resize_w` int(11) DEFAULT NULL,
  `grow_h` int(11) DEFAULT NULL,
  `grow_w` int(11) DEFAULT NULL,
  `clip2top` int(11) DEFAULT NULL,
  `clip2bottom` int(11) DEFAULT NULL,
  `clip2left` int(11) DEFAULT NULL,
  `clip2right` int(11) DEFAULT NULL,
  `codec` varchar(128) NOT NULL,
  `codec_param` varchar(128) DEFAULT NULL,
  `bitrate` int(11) DEFAULT NULL,
  `a_sample_r` int(11) DEFAULT NULL,
  `a_bitrate` int(11) DEFAULT NULL,
  `two_pass` tinyint(1) DEFAULT NULL,
  `tc_param` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`intid`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE `eit_cache` (
  `chanid` int(10) NOT NULL,
  `eventid` int(10) unsigned NOT NULL DEFAULT '0',
  `tableid` tinyint(3) unsigned NOT NULL,
  `version` tinyint(3) unsigned NOT NULL,
  `endtime` int(10) unsigned NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`chanid`,`eventid`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `filemarkup` (
  `filename` text NOT NULL,
  `mark` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `offset` bigint(20) unsigned DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  KEY `filename` (`filename`(255)),
  KEY `filename_2` (`filename`(255))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `gallerymetadata` (
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `angle` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`image`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `gamemetadata` (
  `system` varchar(128) NOT NULL DEFAULT '',
  `romname` varchar(128) NOT NULL DEFAULT '',
  `gamename` varchar(128) NOT NULL DEFAULT '',
  `genre` varchar(128) NOT NULL DEFAULT '',
  `year` varchar(10) NOT NULL DEFAULT '',
  `favorite` tinyint(1) DEFAULT NULL,
  `rompath` varchar(255) NOT NULL DEFAULT '',
  `screenshot` varchar(255) NOT NULL,
  `fanart` varchar(255) NOT NULL,
  `plot` text NOT NULL,
  `boxart` varchar(255) NOT NULL,
  `gametype` varchar(64) NOT NULL DEFAULT '',
  `diskcount` tinyint(1) NOT NULL DEFAULT '1',
  `country` varchar(128) NOT NULL DEFAULT '',
  `crc_value` varchar(64) NOT NULL DEFAULT '',
  `display` tinyint(1) NOT NULL DEFAULT '1',
  `version` varchar(64) NOT NULL DEFAULT '',
  `publisher` varchar(128) NOT NULL DEFAULT '',
  KEY `system` (`system`),
  KEY `year` (`year`),
  KEY `romname` (`romname`),
  KEY `gamename` (`gamename`),
  KEY `genre` (`genre`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `gameplayers` (
  `gameplayerid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `playername` varchar(64) NOT NULL DEFAULT '',
  `workingpath` varchar(255) NOT NULL DEFAULT '',
  `rompath` varchar(255) NOT NULL DEFAULT '',
  `screenshots` varchar(255) NOT NULL DEFAULT '',
  `commandline` text NOT NULL,
  `gametype` varchar(64) NOT NULL DEFAULT '',
  `extensions` varchar(128) NOT NULL DEFAULT '',
  `spandisks` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gameplayerid`),
  UNIQUE KEY `playername` (`playername`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `housekeeping` (
  `tag` varchar(64) NOT NULL DEFAULT '',
  `lastrun` datetime DEFAULT NULL,
  PRIMARY KEY (`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `inputgroup` (
  `cardinputid` int(10) unsigned NOT NULL,
  `inputgroupid` int(10) unsigned NOT NULL,
  `inputgroupname` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `internetcontent` (
  `name` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `type` smallint(3) NOT NULL,
  `author` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `commandline` text NOT NULL,
  `version` double NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `search` tinyint(1) NOT NULL,
  `tree` tinyint(1) NOT NULL,
  `podcast` tinyint(1) NOT NULL,
  `download` tinyint(1) NOT NULL,
  `host` varchar(128) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `internetcontentarticles` (
  `feedtitle` varchar(255) NOT NULL,
  `path` text NOT NULL,
  `paththumb` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) NOT NULL,
  `season` smallint(5) NOT NULL DEFAULT '0',
  `episode` smallint(5) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `url` text NOT NULL,
  `type` smallint(3) NOT NULL,
  `thumbnail` text NOT NULL,
  `mediaURL` text NOT NULL,
  `author` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time` int(11) NOT NULL,
  `rating` varchar(255) NOT NULL,
  `filesize` bigint(20) NOT NULL,
  `player` varchar(255) NOT NULL,
  `playerargs` text NOT NULL,
  `download` varchar(255) NOT NULL,
  `downloadargs` text NOT NULL,
  `width` smallint(6) NOT NULL,
  `height` smallint(6) NOT NULL,
  `language` varchar(128) NOT NULL,
  `podcast` tinyint(1) NOT NULL,
  `downloadable` tinyint(1) NOT NULL,
  `customhtml` tinyint(1) NOT NULL,
  `countries` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `inuseprograms` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `recusage` varchar(128) NOT NULL DEFAULT '',
  `lastupdatetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hostname` varchar(64) NOT NULL DEFAULT '',
  `rechost` varchar(64) NOT NULL,
  `recdir` varchar(255) NOT NULL DEFAULT '',
  KEY `chanid` (`chanid`,`starttime`),
  KEY `recusage` (`recusage`,`lastupdatetime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `jobqueue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chanid` int(10) NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `inserttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `type` int(11) NOT NULL DEFAULT '0',
  `cmds` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `statustime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `hostname` varchar(64) NOT NULL DEFAULT '',
  `args` blob NOT NULL,
  `comment` varchar(128) NOT NULL DEFAULT '',
  `schedruntime` datetime NOT NULL DEFAULT '2007-01-01 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chanid` (`chanid`,`starttime`,`type`,`inserttime`)
) ENGINE=MyISAM AUTO_INCREMENT=1657 DEFAULT CHARSET=utf8;

CREATE TABLE `jumppoints` (
  `destination` varchar(128) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `keylist` varchar(128) DEFAULT NULL,
  `hostname` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`destination`,`hostname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `keybindings` (
  `context` varchar(32) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `keylist` varchar(128) DEFAULT NULL,
  `hostname` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`context`,`action`,`hostname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `keyword` (
  `phrase` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `searchtype` int(10) unsigned NOT NULL DEFAULT '3',
  UNIQUE KEY `phrase` (`phrase`,`searchtype`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `mamemetadata` (
  `romname` varchar(128) NOT NULL DEFAULT '',
  `manu` varchar(128) NOT NULL DEFAULT '',
  `cloneof` varchar(128) NOT NULL DEFAULT '',
  `romof` varchar(128) NOT NULL DEFAULT '',
  `driver` varchar(128) NOT NULL DEFAULT '',
  `cpu1` varchar(128) NOT NULL DEFAULT '',
  `cpu2` varchar(128) NOT NULL DEFAULT '',
  `cpu3` varchar(128) NOT NULL DEFAULT '',
  `cpu4` varchar(128) NOT NULL DEFAULT '',
  `sound1` varchar(128) NOT NULL DEFAULT '',
  `sound2` varchar(128) NOT NULL DEFAULT '',
  `sound3` varchar(128) NOT NULL DEFAULT '',
  `sound4` varchar(128) NOT NULL DEFAULT '',
  `players` int(10) unsigned NOT NULL DEFAULT '0',
  `buttons` int(10) unsigned NOT NULL DEFAULT '0',
  `image_searched` tinyint(1) NOT NULL DEFAULT '0',
  `rom_path` varchar(255) NOT NULL DEFAULT '',
  KEY `romname` (`romname`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `mamesettings` (
  `romname` varchar(128) NOT NULL DEFAULT '',
  `usedefault` tinyint(1) NOT NULL DEFAULT '0',
  `fullscreen` tinyint(2) NOT NULL DEFAULT '0',
  `scanlines` tinyint(1) NOT NULL DEFAULT '0',
  `extra_artwork` tinyint(1) NOT NULL DEFAULT '0',
  `autoframeskip` tinyint(1) NOT NULL DEFAULT '0',
  `autocolordepth` tinyint(1) NOT NULL DEFAULT '0',
  `rotleft` tinyint(1) NOT NULL DEFAULT '0',
  `rotright` tinyint(1) NOT NULL DEFAULT '0',
  `flipx` tinyint(1) NOT NULL DEFAULT '0',
  `flipy` tinyint(1) NOT NULL DEFAULT '0',
  `scale` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `antialias` tinyint(1) NOT NULL DEFAULT '0',
  `translucency` tinyint(1) NOT NULL DEFAULT '0',
  `beam` float NOT NULL DEFAULT '0',
  `flicker` float NOT NULL DEFAULT '0',
  `vectorres` int(11) NOT NULL DEFAULT '0',
  `analogjoy` tinyint(1) NOT NULL DEFAULT '0',
  `mouse` tinyint(1) NOT NULL DEFAULT '0',
  `winkeys` tinyint(1) NOT NULL DEFAULT '0',
  `grabmouse` tinyint(1) NOT NULL DEFAULT '0',
  `joytype` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `sound` tinyint(1) NOT NULL DEFAULT '0',
  `samples` tinyint(1) NOT NULL DEFAULT '0',
  `fakesound` tinyint(1) NOT NULL DEFAULT '0',
  `volume` tinyint(4) NOT NULL DEFAULT '0',
  `cheat` tinyint(1) NOT NULL DEFAULT '0',
  `extraoption` varchar(128) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `movies_movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moviename` varchar(255) DEFAULT NULL,
  `rating` varchar(10) DEFAULT NULL,
  `runningtime` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `movies_showtimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `theaterid` int(11) NOT NULL,
  `movieid` int(11) NOT NULL,
  `showtimes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `movies_theaters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `theatername` varchar(100) DEFAULT NULL,
  `theateraddress` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `music_albumart` (
  `albumart_id` int(20) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL DEFAULT '',
  `directory_id` int(20) NOT NULL DEFAULT '0',
  `imagetype` tinyint(3) NOT NULL DEFAULT '0',
  `song_id` int(11) NOT NULL DEFAULT '0',
  `embedded` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`albumart_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18231 DEFAULT CHARSET=utf8;

CREATE TABLE `music_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `artist_id` int(11) unsigned NOT NULL DEFAULT '0',
  `album_name` varchar(255) NOT NULL DEFAULT '',
  `year` smallint(6) NOT NULL DEFAULT '0',
  `compilation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`album_id`),
  KEY `idx_album_name` (`album_name`)
) ENGINE=MyISAM AUTO_INCREMENT=4985 DEFAULT CHARSET=utf8;

CREATE TABLE `music_artists` (
  `artist_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`artist_id`),
  KEY `idx_artist_name` (`artist_name`)
) ENGINE=MyISAM AUTO_INCREMENT=3614 DEFAULT CHARSET=utf8;

CREATE TABLE `music_directories` (
  `directory_id` int(20) NOT NULL AUTO_INCREMENT,
  `path` text NOT NULL,
  `parent_id` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`directory_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1491 DEFAULT CHARSET=utf8;

CREATE TABLE `music_genres` (
  `genre_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `genre` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`genre_id`),
  KEY `idx_genre` (`genre`)
) ENGINE=MyISAM AUTO_INCREMENT=310 DEFAULT CHARSET=utf8;

CREATE TABLE `music_playlists` (
  `playlist_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `playlist_name` varchar(255) NOT NULL DEFAULT '',
  `playlist_songs` text NOT NULL,
  `last_accessed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `length` int(11) unsigned NOT NULL DEFAULT '0',
  `songcount` smallint(8) unsigned NOT NULL DEFAULT '0',
  `hostname` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`playlist_id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

CREATE TABLE `music_smartplaylist_categories` (
  `categoryid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`categoryid`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `music_smartplaylist_items` (
  `smartplaylistitemid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `smartplaylistid` int(10) unsigned NOT NULL DEFAULT '0',
  `field` varchar(50) NOT NULL,
  `operator` varchar(20) NOT NULL,
  `value1` varchar(255) NOT NULL,
  `value2` varchar(255) NOT NULL,
  PRIMARY KEY (`smartplaylistitemid`),
  KEY `smartplaylistid` (`smartplaylistid`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE `music_smartplaylists` (
  `smartplaylistid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `categoryid` int(10) unsigned NOT NULL DEFAULT '0',
  `matchtype` set('All','Any') CHARACTER SET latin1 NOT NULL DEFAULT 'All',
  `orderby` varchar(128) NOT NULL DEFAULT '',
  `limitto` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`smartplaylistid`),
  KEY `name` (`name`),
  KEY `categoryid` (`categoryid`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE `music_songs` (
  `song_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filename` text NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `track` smallint(6) unsigned NOT NULL DEFAULT '0',
  `artist_id` int(11) unsigned NOT NULL DEFAULT '0',
  `album_id` int(11) unsigned NOT NULL DEFAULT '0',
  `genre_id` int(11) unsigned NOT NULL DEFAULT '0',
  `year` smallint(6) NOT NULL DEFAULT '0',
  `length` int(11) unsigned NOT NULL DEFAULT '0',
  `numplays` int(11) unsigned NOT NULL DEFAULT '0',
  `rating` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `lastplay` datetime DEFAULT NULL,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `format` varchar(4) NOT NULL DEFAULT '0',
  `mythdigest` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `disc_count` smallint(5) unsigned DEFAULT '0',
  `disc_number` smallint(5) unsigned DEFAULT '0',
  `track_count` smallint(5) unsigned DEFAULT '0',
  `start_time` int(10) unsigned DEFAULT '0',
  `stop_time` int(10) unsigned DEFAULT NULL,
  `eq_preset` varchar(255) DEFAULT NULL,
  `relative_volume` tinyint(4) DEFAULT '0',
  `sample_rate` int(10) unsigned DEFAULT '0',
  `bitrate` int(10) unsigned DEFAULT '0',
  `bpm` smallint(5) unsigned DEFAULT NULL,
  `directory_id` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`song_id`),
  KEY `idx_name` (`name`),
  KEY `idx_mythdigest` (`mythdigest`),
  KEY `directory_id` (`directory_id`),
  KEY `album_id` (`album_id`),
  KEY `genre_id` (`genre_id`),
  KEY `artist_id` (`artist_id`)
) ENGINE=MyISAM AUTO_INCREMENT=42356 DEFAULT CHARSET=utf8;

CREATE TABLE `music_stats` (
  `num_artists` smallint(5) unsigned NOT NULL DEFAULT '0',
  `num_albums` smallint(5) unsigned NOT NULL DEFAULT '0',
  `num_songs` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `num_genres` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `total_time` varchar(12) NOT NULL DEFAULT '0',
  `total_size` varchar(10) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `mythexport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(65) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `pubDate` datetime NOT NULL,
  `delDate` datetime DEFAULT NULL,
  `airDate` datetime NOT NULL,
  `podcastName` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `mythexport_job_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(25) NOT NULL,
  `param` longtext,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `mythlog` (
  `logid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(32) NOT NULL DEFAULT '',
  `priority` int(11) NOT NULL DEFAULT '0',
  `acknowledged` tinyint(1) DEFAULT '0',
  `logdate` datetime DEFAULT NULL,
  `host` varchar(128) DEFAULT NULL,
  `message` varchar(255) NOT NULL DEFAULT '',
  `details` text,
  PRIMARY KEY (`logid`),
  KEY `module` (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `mythweb_sessions` (
  `id` varchar(128) NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `modified` (`modified`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `neskeyword` (
  `keyword` varchar(8) DEFAULT NULL,
  `value` varchar(80) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `nestitle` (
  `id` int(11) DEFAULT NULL,
  `description` varchar(160) DEFAULT NULL,
  `designer` int(11) DEFAULT NULL,
  `publisher` int(11) DEFAULT NULL,
  `releasedate` year(4) DEFAULT NULL,
  `screenshot` int(11) DEFAULT NULL,
  `keywords` varchar(40) DEFAULT NULL,
  FULLTEXT KEY `description` (`description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `netflix` (
  `name` varchar(100) NOT NULL DEFAULT '',
  `category` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `ico` varchar(255) DEFAULT NULL,
  `updated` int(10) unsigned DEFAULT NULL,
  `is_queue` int(10) unsigned DEFAULT NULL,
  `queue` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`,`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `netvisionrssitems` (
  `feedtitle` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `url` text NOT NULL,
  `thumbnail` text NOT NULL,
  `mediaURL` text NOT NULL,
  `author` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time` int(11) NOT NULL,
  `rating` varchar(255) NOT NULL,
  `filesize` bigint(20) NOT NULL,
  `player` varchar(255) NOT NULL,
  `playerargs` text NOT NULL,
  `download` varchar(255) NOT NULL,
  `downloadargs` text NOT NULL,
  `width` smallint(6) NOT NULL,
  `height` smallint(6) NOT NULL,
  `language` varchar(128) DEFAULT NULL,
  `downloadable` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `netvisionsearchgrabbers` (
  `name` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `commandline` text NOT NULL,
  `host` varchar(128) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `netvisionsites` (
  `name` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `description` text,
  `url` text NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `download` tinyint(1) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `netvisiontreegrabbers` (
  `name` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `commandline` text NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `host` varchar(128) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `netvisiontreeitems` (
  `feedtitle` varchar(255) NOT NULL,
  `path` text NOT NULL,
  `paththumb` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `url` text NOT NULL,
  `thumbnail` text NOT NULL,
  `mediaURL` text NOT NULL,
  `author` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time` int(11) NOT NULL,
  `rating` varchar(255) NOT NULL,
  `filesize` bigint(20) NOT NULL,
  `player` varchar(255) NOT NULL,
  `playerargs` text NOT NULL,
  `download` varchar(255) NOT NULL,
  `downloadargs` text NOT NULL,
  `width` smallint(6) NOT NULL,
  `height` smallint(6) NOT NULL,
  `language` varchar(128) NOT NULL,
  `downloadable` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `networkiconmap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network` varchar(20) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `network` (`network`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `newssites` (
  `name` varchar(100) NOT NULL DEFAULT '',
  `category` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `ico` varchar(255) DEFAULT NULL,
  `updated` int(10) unsigned DEFAULT NULL,
  `podcast` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `oldfind` (
  `recordid` int(11) NOT NULL DEFAULT '0',
  `findid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`recordid`,`findid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `oldprogram` (
  `oldtitle` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `airdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`oldtitle`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `oldrecorded` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `endtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title` varchar(128) NOT NULL DEFAULT '',
  `subtitle` varchar(128) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `seriesid` varchar(40) NOT NULL DEFAULT '',
  `programid` varchar(40) NOT NULL DEFAULT '',
  `findid` int(11) NOT NULL DEFAULT '0',
  `recordid` int(11) NOT NULL DEFAULT '0',
  `station` varchar(20) NOT NULL DEFAULT '',
  `rectype` int(10) unsigned NOT NULL DEFAULT '0',
  `duplicate` tinyint(1) NOT NULL DEFAULT '0',
  `recstatus` int(11) NOT NULL DEFAULT '0',
  `reactivate` smallint(6) NOT NULL DEFAULT '0',
  `generic` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`station`,`starttime`,`title`),
  KEY `endtime` (`endtime`),
  KEY `title` (`title`),
  KEY `seriesid` (`seriesid`),
  KEY `programid` (`programid`),
  KEY `recordid` (`recordid`),
  KEY `recstatus` (`recstatus`,`programid`,`seriesid`),
  KEY `recstatus_2` (`recstatus`,`title`,`subtitle`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `people` (
  `person` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`person`),
  UNIQUE KEY `name` (`name`(41))
) ENGINE=MyISAM AUTO_INCREMENT=102476 DEFAULT CHARSET=utf8;

CREATE TABLE `phonecallhistory` (
  `recid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `displayname` text NOT NULL,
  `url` text NOT NULL,
  `timestamp` text NOT NULL,
  `duration` int(10) unsigned NOT NULL DEFAULT '0',
  `directionin` int(10) unsigned NOT NULL DEFAULT '0',
  `directoryref` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`recid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `phonedirectory` (
  `intid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` text NOT NULL,
  `firstname` text,
  `surname` text,
  `url` text NOT NULL,
  `directory` text NOT NULL,
  `photofile` text,
  `speeddial` int(10) unsigned NOT NULL DEFAULT '0',
  `onhomelan` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`intid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE `pidcache` (
  `chanid` smallint(6) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '-1',
  `tableid` int(11) NOT NULL DEFAULT '-1',
  KEY `chanid` (`chanid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `playgroup` (
  `name` varchar(32) NOT NULL DEFAULT '',
  `titlematch` varchar(255) NOT NULL DEFAULT '',
  `skipahead` int(11) NOT NULL DEFAULT '0',
  `skipback` int(11) NOT NULL DEFAULT '0',
  `timestretch` int(11) NOT NULL DEFAULT '0',
  `jump` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `powerpriority` (
  `priorityname` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `recpriority` int(10) NOT NULL DEFAULT '0',
  `selectclause` text NOT NULL,
  PRIMARY KEY (`priorityname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `profilegroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `cardtype` varchar(32) NOT NULL DEFAULT 'V4L',
  `is_default` int(1) DEFAULT '0',
  `hostname` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`hostname`),
  KEY `cardtype` (`cardtype`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

CREATE TABLE `program` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `endtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title` varchar(128) NOT NULL DEFAULT '',
  `subtitle` varchar(128) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `category_type` varchar(64) NOT NULL DEFAULT '',
  `airdate` year(4) NOT NULL DEFAULT '0000',
  `stars` float NOT NULL DEFAULT '0',
  `previouslyshown` tinyint(4) NOT NULL DEFAULT '0',
  `title_pronounce` varchar(128) NOT NULL DEFAULT '',
  `stereo` tinyint(1) NOT NULL DEFAULT '0',
  `subtitled` tinyint(1) NOT NULL DEFAULT '0',
  `hdtv` tinyint(1) NOT NULL DEFAULT '0',
  `closecaptioned` tinyint(1) NOT NULL DEFAULT '0',
  `partnumber` int(11) NOT NULL DEFAULT '0',
  `parttotal` int(11) NOT NULL DEFAULT '0',
  `seriesid` varchar(64) NOT NULL DEFAULT '',
  `originalairdate` date DEFAULT NULL,
  `showtype` varchar(30) NOT NULL DEFAULT '',
  `colorcode` varchar(20) NOT NULL DEFAULT '',
  `syndicatedepisodenumber` varchar(20) NOT NULL DEFAULT '',
  `programid` varchar(64) NOT NULL DEFAULT '',
  `manualid` int(10) unsigned NOT NULL DEFAULT '0',
  `generic` tinyint(1) DEFAULT '0',
  `listingsource` int(11) NOT NULL DEFAULT '0',
  `first` tinyint(1) NOT NULL DEFAULT '0',
  `last` tinyint(1) NOT NULL DEFAULT '0',
  `audioprop` set('STEREO','MONO','SURROUND','DOLBY','HARDHEAR','VISUALIMPAIR') CHARACTER SET latin1 NOT NULL,
  `subtitletypes` set('HARDHEAR','NORMAL','ONSCREEN','SIGNED') CHARACTER SET latin1 NOT NULL,
  `videoprop` set('HDTV','WIDESCREEN','AVC') CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`chanid`,`starttime`,`manualid`),
  KEY `endtime` (`endtime`),
  KEY `title` (`title`),
  KEY `title_pronounce` (`title_pronounce`),
  KEY `seriesid` (`seriesid`),
  KEY `id_start_end` (`chanid`,`starttime`,`endtime`),
  KEY `program_manualid` (`manualid`),
  KEY `previouslyshown` (`previouslyshown`),
  KEY `programid` (`programid`,`starttime`),
  KEY `starttime` (`starttime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `programgenres` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `relevance` char(1) NOT NULL DEFAULT '',
  `genre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`chanid`,`starttime`,`relevance`),
  KEY `genre` (`genre`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `programrating` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `system` varchar(8) DEFAULT NULL,
  `rating` varchar(16) DEFAULT NULL,
  UNIQUE KEY `chanid` (`chanid`,`starttime`,`system`,`rating`),
  KEY `starttime` (`starttime`,`system`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `recgrouppassword` (
  `recgroup` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`recgroup`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `record` (
  `recordid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  `chanid` int(10) unsigned DEFAULT NULL,
  `starttime` time NOT NULL DEFAULT '00:00:00',
  `startdate` date NOT NULL DEFAULT '0000-00-00',
  `endtime` time NOT NULL DEFAULT '00:00:00',
  `enddate` date NOT NULL DEFAULT '0000-00-00',
  `title` varchar(128) NOT NULL DEFAULT '',
  `subtitle` varchar(128) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `profile` varchar(128) NOT NULL DEFAULT 'Default',
  `recpriority` int(10) NOT NULL DEFAULT '0',
  `autoexpire` int(11) NOT NULL DEFAULT '0',
  `maxepisodes` int(11) NOT NULL DEFAULT '0',
  `maxnewest` int(11) NOT NULL DEFAULT '0',
  `startoffset` int(11) NOT NULL DEFAULT '0',
  `endoffset` int(11) NOT NULL DEFAULT '0',
  `recgroup` varchar(32) NOT NULL DEFAULT 'Default',
  `dupmethod` int(11) NOT NULL DEFAULT '6',
  `dupin` int(11) NOT NULL DEFAULT '15',
  `station` varchar(20) NOT NULL DEFAULT '',
  `seriesid` varchar(40) NOT NULL DEFAULT '',
  `programid` varchar(40) NOT NULL DEFAULT '',
  `search` int(10) unsigned NOT NULL DEFAULT '0',
  `autotranscode` tinyint(1) NOT NULL DEFAULT '0',
  `autocommflag` tinyint(1) NOT NULL DEFAULT '0',
  `autouserjob1` tinyint(1) NOT NULL DEFAULT '0',
  `autouserjob2` tinyint(1) NOT NULL DEFAULT '0',
  `autouserjob3` tinyint(1) NOT NULL DEFAULT '0',
  `autouserjob4` tinyint(1) NOT NULL DEFAULT '0',
  `findday` tinyint(4) NOT NULL DEFAULT '0',
  `findtime` time NOT NULL DEFAULT '00:00:00',
  `findid` int(11) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `parentid` int(11) NOT NULL DEFAULT '0',
  `transcoder` int(11) NOT NULL DEFAULT '0',
  `tsdefault` float NOT NULL DEFAULT '1',
  `playgroup` varchar(32) NOT NULL DEFAULT 'Default',
  `prefinput` int(10) NOT NULL DEFAULT '0',
  `next_record` datetime NOT NULL,
  `last_record` datetime NOT NULL,
  `last_delete` datetime NOT NULL,
  `storagegroup` varchar(32) NOT NULL DEFAULT 'Default',
  `avg_delay` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`recordid`),
  KEY `chanid` (`chanid`,`starttime`),
  KEY `title` (`title`),
  KEY `seriesid` (`seriesid`),
  KEY `programid` (`programid`),
  KEY `maxepisodes` (`maxepisodes`),
  KEY `search` (`search`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=1391 DEFAULT CHARSET=utf8;

CREATE TABLE `record_tmp` (
  `recordid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  `chanid` int(10) unsigned DEFAULT NULL,
  `starttime` time NOT NULL DEFAULT '00:00:00',
  `startdate` date NOT NULL DEFAULT '0000-00-00',
  `endtime` time NOT NULL DEFAULT '00:00:00',
  `enddate` date NOT NULL DEFAULT '0000-00-00',
  `title` varchar(128) NOT NULL DEFAULT '',
  `subtitle` varchar(128) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `profile` varchar(128) NOT NULL DEFAULT 'Default',
  `recpriority` int(10) NOT NULL DEFAULT '0',
  `autoexpire` int(11) NOT NULL DEFAULT '0',
  `maxepisodes` int(11) NOT NULL DEFAULT '0',
  `maxnewest` int(11) NOT NULL DEFAULT '0',
  `startoffset` int(11) NOT NULL DEFAULT '0',
  `endoffset` int(11) NOT NULL DEFAULT '0',
  `recgroup` varchar(32) NOT NULL DEFAULT 'Default',
  `dupmethod` int(11) NOT NULL DEFAULT '6',
  `dupin` int(11) NOT NULL DEFAULT '15',
  `station` varchar(20) NOT NULL DEFAULT '',
  `seriesid` varchar(40) NOT NULL DEFAULT '',
  `programid` varchar(40) NOT NULL DEFAULT '',
  `search` int(10) unsigned NOT NULL DEFAULT '0',
  `autotranscode` tinyint(1) NOT NULL DEFAULT '0',
  `autocommflag` tinyint(1) NOT NULL DEFAULT '0',
  `autouserjob1` tinyint(1) NOT NULL DEFAULT '0',
  `autouserjob2` tinyint(1) NOT NULL DEFAULT '0',
  `autouserjob3` tinyint(1) NOT NULL DEFAULT '0',
  `autouserjob4` tinyint(1) NOT NULL DEFAULT '0',
  `findday` tinyint(4) NOT NULL DEFAULT '0',
  `findtime` time NOT NULL DEFAULT '00:00:00',
  `findid` int(11) NOT NULL DEFAULT '0',
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `parentid` int(11) NOT NULL DEFAULT '0',
  `transcoder` int(11) NOT NULL DEFAULT '0',
  `tsdefault` float NOT NULL DEFAULT '1',
  `playgroup` varchar(32) NOT NULL DEFAULT 'Default',
  `prefinput` int(10) NOT NULL DEFAULT '0',
  `next_record` datetime NOT NULL,
  `last_record` datetime NOT NULL,
  `last_delete` datetime NOT NULL,
  `storagegroup` varchar(32) NOT NULL DEFAULT 'Default',
  `avg_delay` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`recordid`)
) ENGINE=MyISAM AUTO_INCREMENT=1389 DEFAULT CHARSET=utf8;

CREATE TABLE `recorded` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `endtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title` varchar(128) NOT NULL DEFAULT '',
  `subtitle` varchar(128) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `hostname` varchar(64) NOT NULL DEFAULT '',
  `bookmark` tinyint(1) NOT NULL DEFAULT '0',
  `editing` int(10) unsigned NOT NULL DEFAULT '0',
  `cutlist` tinyint(1) NOT NULL DEFAULT '0',
  `autoexpire` int(11) NOT NULL DEFAULT '0',
  `commflagged` int(10) unsigned NOT NULL DEFAULT '0',
  `recgroup` varchar(32) NOT NULL DEFAULT 'Default',
  `recordid` int(11) DEFAULT NULL,
  `seriesid` varchar(40) NOT NULL DEFAULT '',
  `programid` varchar(40) NOT NULL DEFAULT '',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `filesize` bigint(20) NOT NULL DEFAULT '0',
  `stars` float NOT NULL DEFAULT '0',
  `previouslyshown` tinyint(1) DEFAULT '0',
  `originalairdate` date DEFAULT NULL,
  `preserve` tinyint(1) NOT NULL DEFAULT '0',
  `findid` int(11) NOT NULL DEFAULT '0',
  `deletepending` tinyint(1) NOT NULL DEFAULT '0',
  `transcoder` int(11) NOT NULL DEFAULT '0',
  `timestretch` float NOT NULL DEFAULT '1',
  `recpriority` int(11) NOT NULL DEFAULT '0',
  `basename` varchar(255) NOT NULL,
  `progstart` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `progend` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `playgroup` varchar(32) NOT NULL DEFAULT 'Default',
  `profile` varchar(32) NOT NULL DEFAULT '',
  `duplicate` tinyint(1) NOT NULL DEFAULT '0',
  `transcoded` tinyint(1) NOT NULL DEFAULT '0',
  `watched` tinyint(4) NOT NULL DEFAULT '0',
  `storagegroup` varchar(32) NOT NULL DEFAULT 'Default',
  `bookmarkupdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`chanid`,`starttime`),
  KEY `endtime` (`endtime`),
  KEY `seriesid` (`seriesid`),
  KEY `programid` (`programid`),
  KEY `title` (`title`),
  KEY `recordid` (`recordid`),
  KEY `recordid_2` (`recordid`),
  KEY `recordid_3` (`recordid`),
  KEY `recordid_4` (`recordid`),
  KEY `recordid_5` (`recordid`),
  KEY `recordid_6` (`recordid`),
  KEY `recordid_7` (`recordid`),
  KEY `recordid_8` (`recordid`),
  KEY `recordid_9` (`recordid`),
  KEY `deletepending` (`deletepending`,`lastmodified`),
  KEY `recgroup` (`recgroup`,`endtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `recordedcredits` (
  `person` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `role` set('actor','director','producer','executive_producer','writer','guest_star','host','adapter','presenter','commentator','guest') CHARACTER SET latin1 NOT NULL DEFAULT '',
  UNIQUE KEY `chanid` (`chanid`,`starttime`,`person`,`role`),
  KEY `person` (`person`,`role`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `recordedfile` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `basename` varchar(128) NOT NULL DEFAULT '',
  `filesize` bigint(20) NOT NULL DEFAULT '0',
  `width` smallint(5) unsigned NOT NULL DEFAULT '0',
  `height` smallint(5) unsigned NOT NULL DEFAULT '0',
  `fps` float(6,3) NOT NULL DEFAULT '0.000',
  `aspect` float(8,6) NOT NULL DEFAULT '0.000000',
  `audio_sample_rate` smallint(5) unsigned NOT NULL DEFAULT '0',
  `audio_bits_per_sample` smallint(5) unsigned NOT NULL DEFAULT '0',
  `audio_channels` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `audio_type` varchar(255) NOT NULL DEFAULT '',
  `video_type` varchar(255) NOT NULL DEFAULT '',
  `comment` varchar(255) NOT NULL DEFAULT '',
  `hostname` varchar(64) NOT NULL,
  `storagegroup` varchar(32) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chanid` (`chanid`,`starttime`,`basename`),
  KEY `basename` (`basename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `recordedmarkup` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mark` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `data` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`chanid`,`starttime`,`type`,`mark`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `recordedprogram` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `endtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title` varchar(128) NOT NULL DEFAULT '',
  `subtitle` varchar(128) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `category_type` varchar(64) NOT NULL DEFAULT '',
  `airdate` year(4) NOT NULL DEFAULT '0000',
  `stars` float unsigned NOT NULL DEFAULT '0',
  `previouslyshown` tinyint(4) NOT NULL DEFAULT '0',
  `title_pronounce` varchar(128) NOT NULL DEFAULT '',
  `stereo` tinyint(1) NOT NULL DEFAULT '0',
  `subtitled` tinyint(1) NOT NULL DEFAULT '0',
  `hdtv` tinyint(1) NOT NULL DEFAULT '0',
  `closecaptioned` tinyint(1) NOT NULL DEFAULT '0',
  `partnumber` int(11) NOT NULL DEFAULT '0',
  `parttotal` int(11) NOT NULL DEFAULT '0',
  `seriesid` varchar(40) NOT NULL DEFAULT '',
  `originalairdate` date DEFAULT NULL,
  `showtype` varchar(30) NOT NULL DEFAULT '',
  `colorcode` varchar(20) NOT NULL DEFAULT '',
  `syndicatedepisodenumber` varchar(20) NOT NULL DEFAULT '',
  `programid` varchar(40) NOT NULL DEFAULT '',
  `manualid` int(10) unsigned NOT NULL DEFAULT '0',
  `generic` tinyint(1) DEFAULT '0',
  `listingsource` int(11) NOT NULL DEFAULT '0',
  `first` tinyint(1) NOT NULL DEFAULT '0',
  `last` tinyint(1) NOT NULL DEFAULT '0',
  `audioprop` set('STEREO','MONO','SURROUND','DOLBY','HARDHEAR','VISUALIMPAIR') CHARACTER SET latin1 NOT NULL,
  `subtitletypes` set('HARDHEAR','NORMAL','ONSCREEN','SIGNED') CHARACTER SET latin1 NOT NULL,
  `videoprop` set('HDTV','WIDESCREEN','AVC','720','1080') NOT NULL,
  PRIMARY KEY (`chanid`,`starttime`,`manualid`),
  KEY `endtime` (`endtime`),
  KEY `title` (`title`),
  KEY `title_pronounce` (`title_pronounce`),
  KEY `seriesid` (`seriesid`),
  KEY `programid` (`programid`),
  KEY `id_start_end` (`chanid`,`starttime`,`endtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `recordedrating` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `system` varchar(8) DEFAULT NULL,
  `rating` varchar(16) DEFAULT NULL,
  UNIQUE KEY `chanid` (`chanid`,`starttime`,`system`,`rating`),
  KEY `starttime` (`starttime`,`system`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `recordedseek` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mark` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `offset` bigint(20) unsigned NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`chanid`,`starttime`,`type`,`mark`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `recordingprofiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `videocodec` varchar(128) DEFAULT NULL,
  `audiocodec` varchar(128) DEFAULT NULL,
  `profilegroup` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `profilegroup` (`profilegroup`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

CREATE TABLE `recordmatch` (
  `recordid` int(10) unsigned DEFAULT NULL,
  `chanid` int(10) unsigned DEFAULT NULL,
  `starttime` datetime DEFAULT NULL,
  `manualid` int(10) unsigned DEFAULT NULL,
  `oldrecduplicate` tinyint(1) DEFAULT NULL,
  `recduplicate` tinyint(1) DEFAULT NULL,
  `findduplicate` tinyint(1) DEFAULT NULL,
  `oldrecstatus` int(11) DEFAULT NULL,
  KEY `recordid` (`recordid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `romdb` (
  `crc` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `category` varchar(128) NOT NULL DEFAULT '',
  `year` varchar(10) NOT NULL DEFAULT '',
  `manufacturer` varchar(128) NOT NULL DEFAULT '',
  `country` varchar(128) NOT NULL DEFAULT '',
  `publisher` varchar(128) NOT NULL DEFAULT '',
  `platform` varchar(64) NOT NULL DEFAULT '',
  `filesize` int(12) DEFAULT NULL,
  `flags` varchar(64) NOT NULL DEFAULT '',
  `version` varchar(64) NOT NULL DEFAULT '',
  `binfile` varchar(64) NOT NULL DEFAULT '',
  KEY `crc` (`crc`),
  KEY `year` (`year`),
  KEY `category` (`category`),
  KEY `name` (`name`),
  KEY `description` (`description`),
  KEY `platform` (`platform`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `schemalock` (
  `schemalock` int(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `settings` (
  `value` varchar(128) NOT NULL DEFAULT '',
  `data` text,
  `hostname` varchar(64) DEFAULT NULL,
  KEY `value` (`value`,`hostname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `snessettings` (
  `romname` varchar(128) NOT NULL DEFAULT '',
  `usedefault` tinyint(1) NOT NULL DEFAULT '0',
  `transparency` tinyint(1) NOT NULL DEFAULT '0',
  `sixteen` tinyint(1) NOT NULL DEFAULT '0',
  `hires` tinyint(1) NOT NULL DEFAULT '0',
  `interpolate` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `nomodeswitch` tinyint(1) NOT NULL DEFAULT '0',
  `fullscreen` tinyint(1) NOT NULL DEFAULT '0',
  `stretch` tinyint(1) NOT NULL DEFAULT '0',
  `nosound` tinyint(1) NOT NULL DEFAULT '0',
  `soundskip` tinyint(4) NOT NULL DEFAULT '0',
  `stereo` tinyint(1) NOT NULL DEFAULT '0',
  `soundquality` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `envx` tinyint(1) NOT NULL DEFAULT '0',
  `threadsound` tinyint(1) NOT NULL DEFAULT '0',
  `syncsound` tinyint(1) NOT NULL DEFAULT '0',
  `interpolatedsound` tinyint(1) NOT NULL DEFAULT '0',
  `buffersize` int(10) unsigned NOT NULL DEFAULT '0',
  `nosamplecaching` tinyint(1) NOT NULL DEFAULT '0',
  `altsampledecode` tinyint(1) NOT NULL DEFAULT '0',
  `noecho` tinyint(1) NOT NULL DEFAULT '0',
  `nomastervolume` tinyint(1) NOT NULL DEFAULT '0',
  `nojoy` tinyint(1) NOT NULL DEFAULT '0',
  `interleaved` tinyint(1) NOT NULL DEFAULT '0',
  `altinterleaved` tinyint(1) NOT NULL DEFAULT '0',
  `hirom` tinyint(1) NOT NULL DEFAULT '0',
  `lowrom` tinyint(1) NOT NULL DEFAULT '0',
  `header` tinyint(1) NOT NULL DEFAULT '0',
  `noheader` tinyint(1) NOT NULL DEFAULT '0',
  `pal` tinyint(1) NOT NULL DEFAULT '0',
  `ntsc` tinyint(1) NOT NULL DEFAULT '0',
  `layering` tinyint(1) NOT NULL DEFAULT '0',
  `nohdma` tinyint(1) NOT NULL DEFAULT '0',
  `nospeedhacks` tinyint(1) NOT NULL DEFAULT '0',
  `nowindows` tinyint(1) NOT NULL DEFAULT '0',
  `extraoption` varchar(128) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `storagegroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(32) NOT NULL,
  `hostname` varchar(64) NOT NULL DEFAULT '',
  `dirname` varchar(235) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `grouphostdir` (`groupname`,`hostname`,`dirname`),
  KEY `hostname` (`hostname`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `streams` (
  `folder` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `handler` varchar(50) DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `temptable` (
  `value` varchar(128) DEFAULT NULL,
  `data` text,
  `hostname` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `tvchain` (
  `chanid` int(10) unsigned NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `chainid` varchar(128) NOT NULL DEFAULT '',
  `chainpos` int(10) NOT NULL DEFAULT '0',
  `discontinuity` tinyint(1) NOT NULL DEFAULT '0',
  `watching` int(10) NOT NULL DEFAULT '0',
  `hostprefix` varchar(128) NOT NULL DEFAULT '',
  `cardtype` varchar(32) NOT NULL DEFAULT 'V4L',
  `input` varchar(32) NOT NULL DEFAULT '',
  `channame` varchar(32) NOT NULL DEFAULT '',
  `endtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`chanid`,`starttime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `tvosdmenu` (
  `osdcategory` varchar(32) NOT NULL,
  `livetv` tinyint(4) NOT NULL DEFAULT '0',
  `recorded` tinyint(4) NOT NULL DEFAULT '0',
  `video` tinyint(4) NOT NULL DEFAULT '0',
  `dvd` tinyint(4) NOT NULL DEFAULT '0',
  `description` varchar(32) NOT NULL,
  PRIMARY KEY (`osdcategory`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `upnpmedia` (
  `intid` int(10) unsigned NOT NULL DEFAULT '0',
  `class` varchar(64) NOT NULL DEFAULT '',
  `itemtype` varchar(128) NOT NULL DEFAULT '',
  `parentid` int(10) unsigned NOT NULL DEFAULT '0',
  `itemproperties` varchar(255) NOT NULL DEFAULT '',
  `filepath` varchar(512) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `filename` varchar(512) NOT NULL DEFAULT '',
  `coverart` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`intid`),
  KEY `class` (`class`),
  KEY `filepath` (`filepath`(333)),
  KEY `parentid` (`parentid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `videocast` (
  `intid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cast` varchar(128) NOT NULL,
  PRIMARY KEY (`intid`)
) ENGINE=MyISAM AUTO_INCREMENT=1784 DEFAULT CHARSET=utf8;

CREATE TABLE `videocategory` (
  `intid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(128) NOT NULL,
  PRIMARY KEY (`intid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `videocountry` (
  `intid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(128) NOT NULL,
  PRIMARY KEY (`intid`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE `videogenre` (
  `intid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `genre` varchar(128) NOT NULL,
  PRIMARY KEY (`intid`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

CREATE TABLE `videometadata` (
  `intid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `subtitle` text NOT NULL,
  `director` varchar(128) NOT NULL,
  `plot` text,
  `rating` varchar(128) NOT NULL,
  `inetref` varchar(255) NOT NULL,
  `homepage` text NOT NULL,
  `year` int(10) unsigned NOT NULL DEFAULT '0',
  `releasedate` date NOT NULL,
  `userrating` float NOT NULL DEFAULT '0',
  `length` int(10) unsigned NOT NULL DEFAULT '0',
  `season` smallint(5) unsigned NOT NULL DEFAULT '0',
  `episode` smallint(5) unsigned NOT NULL DEFAULT '0',
  `showlevel` int(10) unsigned NOT NULL DEFAULT '0',
  `filename` text NOT NULL,
  `hash` varchar(128) NOT NULL,
  `coverfile` text NOT NULL,
  `childid` int(11) NOT NULL DEFAULT '-1',
  `browse` tinyint(1) NOT NULL DEFAULT '1',
  `watched` tinyint(1) NOT NULL DEFAULT '0',
  `playcommand` varchar(255) DEFAULT NULL,
  `category` int(10) unsigned NOT NULL DEFAULT '0',
  `trailer` text,
  `host` text NOT NULL,
  `screenshot` text,
  `banner` text,
  `fanart` text,
  `insertdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`intid`),
  KEY `director` (`director`),
  KEY `title` (`title`),
  KEY `title_3` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=3708 DEFAULT CHARSET=utf8;

CREATE TABLE `videometadatacast` (
  `idvideo` int(10) unsigned NOT NULL,
  `idcast` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `videometadatacountry` (
  `idvideo` int(10) unsigned NOT NULL DEFAULT '0',
  `idcountry` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `idcountry` (`idcountry`),
  KEY `idvideo` (`idvideo`),
  KEY `idcountry_2` (`idcountry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `videometadatagenre` (
  `idvideo` int(10) unsigned NOT NULL DEFAULT '0',
  `idgenre` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `idvideo` (`idvideo`),
  KEY `idgenre` (`idgenre`),
  KEY `idvideo_2` (`idvideo`),
  KEY `idgenre_2` (`idgenre`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `videosource` (
  `sourceid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `xmltvgrabber` varchar(128) DEFAULT NULL,
  `userid` varchar(128) NOT NULL DEFAULT '',
  `freqtable` varchar(16) NOT NULL DEFAULT 'default',
  `lineupid` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `useeit` smallint(6) NOT NULL DEFAULT '0',
  `configpath` varchar(4096) DEFAULT NULL,
  `dvb_nit_id` int(6) DEFAULT '-1',
  PRIMARY KEY (`sourceid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `videotypes` (
  `intid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `extension` varchar(128) NOT NULL,
  `playcommand` varchar(255) NOT NULL,
  `f_ignore` tinyint(1) DEFAULT NULL,
  `use_default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`intid`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

CREATE TABLE `weatherdatalayout` (
  `location` varchar(64) NOT NULL,
  `dataitem` varchar(64) NOT NULL,
  `weatherscreens_screen_id` int(10) unsigned NOT NULL,
  `weathersourcesettings_sourceid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`location`,`dataitem`,`weatherscreens_screen_id`,`weathersourcesettings_sourceid`),
  KEY `weatherdatalayout_FKIndex1` (`weatherscreens_screen_id`),
  KEY `weatherdatalayout_FKIndex2` (`weathersourcesettings_sourceid`),
  CONSTRAINT `weatherdatalayout_ibfk_1` FOREIGN KEY (`weatherscreens_screen_id`) REFERENCES `weatherscreens` (`screen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `weatherdatalayout_ibfk_2` FOREIGN KEY (`weathersourcesettings_sourceid`) REFERENCES `weathersourcesettings` (`sourceid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weatherscreens` (
  `screen_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `draworder` int(10) unsigned NOT NULL,
  `container` varchar(64) NOT NULL,
  `hostname` varchar(64) DEFAULT NULL,
  `units` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`screen_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE `weathersourcesettings` (
  `sourceid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_name` varchar(64) NOT NULL,
  `update_timeout` int(10) unsigned NOT NULL DEFAULT '600',
  `retrieve_timeout` int(10) unsigned NOT NULL DEFAULT '60',
  `hostname` varchar(64) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `author` varchar(128) DEFAULT NULL,
  `version` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `types` mediumtext,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sourceid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

CREATE TABLE `websites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

