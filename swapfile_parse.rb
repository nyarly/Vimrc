#!/bin/env ruby
module Vim
  module Swapfile
    class Parser
      ParseTemplate =
        [
          [:id0,         "C"],  #char_u  b0_id[2];       /* id for block 0: BLOCK0_ID0 and
          [:id1,         "C"],
          [:version,   "Z10"],  #char_u  b0_version[10]; /* Vim version string */
          [:page_size,   "L"],  #char_u  b0_page_size[4];/* number of bytes per page */
          [:mtime,       "L"],  #char_u  b0_mtime[4];    /* last modification time of file
          [:inode,       "L"],  #char_u  b0_ino[4];      /* inode of b0_fname */
          [:pid,         "L"],  #char_u  b0_pid[4];      /* process id of creator (or 0) */
          [:uname,     "Z40"],  #char_u  b0_uname[B0_UNAME_SIZE]; /* name of user (uid if no name) */
          [:hname,     "Z40"],  #char_u  b0_hname[B0_HNAME_SIZE]; /* host name (if it has a name) */
          [:fname,    "Z898"],  #char_u  b0_fname[B0_FNAME_SIZE_ORG]; /* name of file being edited */
          [:flags,       "C"],  #define b0_flags        b0_fname[B0_FNAME_SIZE_ORG - 2]
          [:dirty,       "C"],  #define b0_dirty        b0_fname[B0_FNAME_SIZE_ORG - 1]
          [:magic_long, "l_"],  #long    b0_magic_long;  /* check for byte order of long */
          [:magic_int,  "i_"],  #int     b0_magic_int;   /* check for byte order of int */
          [:magic_short,"s_"], #short   b0_magic_short; /* check for byte order of short */
          [:magic_char,  "C"]  #char_u  b0_magic_char;  /* check for last char */
      ]

      UnpackTemplate = ParseTemplate.map{|pair| pair[1]}.join
      UnpackNames = ParseTemplate.map{|pair| pair[0]}

      def initialize(swappath)
        @path = swappath
        @parsed = nil
        parse
      end

      attr_reader :parsed

      def dirty?
        @parsed[:dirty] != 0
      end

      def outdated?
        @parsed[:mtime] < File::mtime(File::expand_path(@parsed[:fname])).to_i
      rescue
        false
      end

      def owner_running?
        Process::kill(0, @parsed[:pid])
        return true
      rescue Errno::ESRCH
        return false
      rescue
        return true
      end

      def parse
        File.open(@path, "r") do |swapfile|
          array = swapfile.read.unpack(UnpackTemplate)
          @parsed = Hash[UnpackNames.zip(array)]
        end
      end
    end

    class Decider
      def initialize(path)
        @parser = Parser.new(path)
      end

      def swap_file
        Vim::evaluate("v:swapname")
      end

      def swap_command
        Vim::evaluate("v:swapcommand")
      end

      #:help v:swapchoice
      def swap_decision(letter)
        Vim::message("Setting swapchoice to: #{letter}")
        Vim::command("echo 'Deciding: #{letter}'")
        Vim::command("let v:swapchoice='#{letter}'")
      end

      def be_blase
        if @parser.outdated?
          swap_decision "d"
          return
        end

        if !@parser.dirty?
          swap_decision "d"
          return
        end

        if !@parser.owner_running?
          swap_decision ''
          return
        end

        swap_decision 'r'
      end
    end
  end
end