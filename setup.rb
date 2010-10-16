#!/usr/bin/env ruby

class File
   def self.touch(filename)

      if !(File.exist? filename)
        File.new(filename, "w")
      end

      File.open(filename, 'a'){|f| f.puts ' '}
   end
end


class Setup

require 'yaml'
load 'gui/setupGui.rb'
load 'engines/swift.rb'
load 'engines/festival.rb'
load 'engines/windowEng.rb'

	attr:reader
  attr:engine
	attr:engineList
	

  def initialize(read)
    @defaults = File.expand_path(".") + "/default_setting.yaml"
    @setting_file = File.expand_path("~") + "/.dyslexic_reader"
    @reader = read
	  if RUBY_PLATFORM == "i386-mswin32"
	    @engine = WindowEng.new
	    @engineList = ["WindowEng"]
	  else
	    @engineList = ["Swift","Festival"]
	  end
    loadSettings	
  end

  def openSetupGui()
	  SetupGlade.new(@engineList, self , "setup.glade", nil, "DyslexicReader")
    #DyslexicReaderGlade.new(PROG_PATH, nil, PROG_NAME)
  end

  
  def saveEngine engineName
    @engine = case engineName
        when "Swift" : Swift.new
        when "Festival" : Festival.new
    end
    
    s = self.to_yaml
    aFile = File.new(@setting_file, "w")
    aFile.write(s)
    aFile.close
    
    if @reader
      @reader.loadEng
    end
    
  end
  
  
  
  def engine
    return @engine    
  end
  
  def loadSettings
    File.touch(@setting_file)
    o = YAML::load_file(@setting_file)
    if !(o.respond_to? :engine)
      o = YAML::load_file(@defaults)
    end
    @engine = o.engine
  end
  

	  
end



# Main program
#if __FILE__ == $0
#  # Set values as your own application. 

#  Gtk.main
#end



