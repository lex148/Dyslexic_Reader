#!/usr/bin/ruby

$LOAD_PATH.unshift "."
load 'gui/readerGui.rb'
load 'engines/swift.rb'
load 'engines/festival.rb'
load 'engines/windowEng.rb'
load 'setup.rb'
require 'gtk2'

#$LOAD_PATH.unshift "."
#require 'gui/readerGui.rb'
#require 'engines/swift.rb'
#require 'engines/festival.rb'
#require 'engines/windowEng.rb'
#require 'setup.rb'
#require 'gtk2'


class Reader 



  attr:engine
  attr:old_content
  attr:mainText
  attr:watchLoop
  attr:settings

  def initialize()
    @settings = Setup.new(self)
    @engine = @settings.engine
  end

  def mainTextArea text
    @mainText = text
  end
  
  def loadEng
    if @settings
      @engine = @settings.engine
    end
  end


  def read(text)
    if @engine 
    	@engine.read(text)
    end
  end

  def stop()
    if @engine 
      @engine.stop
    end
  end

  def setup()
	if @settings
      @settings.openSetupGui 
	else
      @settings = Setup.new
	  @settings.openSetupGui 
	end
  end

  def watch(shouldWatch)
    if shouldWatch
	  @watchLoop = true
      startClipboardWatcher
	else
      @watchLoop = false
	end
  end


  def startClipboardWatcher()
    Thread.new() {
		clipboardWatch()
	}
  end

  def clipboardWatch()
    
    
    
    while(@watchLoop) 
      #NOTE: this is in a sepirate prosses. ruby threads does not like Clipboard with gtk2
      # get the clipboard content
      content = `ruby ClipBoardFetcher.rb`
      if(@mainText and content and content != @old_content )
        @old_content = content
        @mainText.buffer.text = content
        stop
          read content
      end
      sleep(1)
    end
  end
	  
end



# Main program
if __FILE__ == $0
  # Set values as your own application. 
  PROG_PATH = "dyslexic_reader.glade"
  PROG_NAME = "DyslexicReader"
  DyslexicReaderGlade.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end



