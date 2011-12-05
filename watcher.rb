#!/usr/bin/ruby

load 'engines/swift.rb'
load 'engines/festival.rb'

$LOAD_PATH.unshift "."
require 'gtk2'

class Watcher

  def initialize()
    @engine = Festival.new
    #@engine.read('test goes here')
    clipboardWatch
  end

  def getText
    begin
      source = Gtk::Clipboard.get(Gdk::Selection::CLIPBOARD)
      #badchars = %w"' ’ – ? …"
      badchars = "".split(//)
      #badchars = ["'", "’", "–", "?", "…"]
      # wait for clipboard content
      text = source.wait_for_text
      badchars.each do |c|
        text = text.gsub(c, "")
      end
      text
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
        @engine.read(content)
        puts "\n" + "*" * 60
        puts content
        puts "*" * 60
        puts "\n\n\n"
      end
      sleep(1)
    end
  end


end

Watcher.new
