#!/usr/bin/ruby

load 'engines/swift.rb'
load 'engines/festival.rb'

$LOAD_PATH.unshift "."
require 'gtk2'

class Watcher

  def initialize()
    @engine = Festival.new
    clipboardWatch
  end

  def getText
    begin
      c = `ruby ClipBoardFetcher.rb`
      c.strip!
    rescue
      ''
    end
  end

  ##watch the clipboard
  def clipboardWatch()
    while(@engine) 
      #NOTE: this is in a sepirate prosses. ruby threads does not like Clipboard with gtk2
      # get the clipboard content
      #content = `ruby ClipBoardFetcher.rb`
      content = getText
      if(content and content != @old_content )
        @old_content = content
        @engine.stop
        puts "\n" + "*" * 60
        puts content
        puts "*" * 60
        puts "\n\n\n"
        @engine.read(content)
      end
      sleep(1)
    end
  end


end

Watcher.new
