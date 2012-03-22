class Festival

  def initialize()
  end

  def read(text)
    stop
    text = clean text
    `rm .temp.wav`
    `rm .temp.txt`
    `touch .temp.txt`
    aFile = File.new(".temp.txt", "w")
    aFile.write(text)
    aFile.close 
    voice = "voice_cmu_us_slt_arctic_hts"
    #command = "text2wave -eval \"(#{voice})\" -o /dev/stdout .temp.txt |lame - - | vlc - vlc://quit"
    #command = "text2wave -o /dev/stdout .temp.txt |lame - - | vlc - vlc://quit"
    command = "text2wave -o /dev/stdout .temp.txt | vlc -I dummy stream:///dev/stdin vlc://quit"
    #command = "text2wave -o .temp.wav .temp.txt && vlc .temp.wav vlc://quit"
    outputText = `#{command}`
    puts outputText
    if (File.exist? ".temp.wav") == false
      logReadError text
    end
  end

  def stop()
  end

  def clean(text)
    text = text.strip
    text = text.delete "\""
  end

  def logReadError(text)
    puts "Logging Error"
    filename = "error.log"
    if File.exist? filename
      logfile = File.new(filename, "w")
      logfile.puts "\n\nErrorReading:" + text
      logfile.close
    else
      logfile = File.open(filename, "a")
      logfile.puts "\n\nErrorReading:" + text
      logfile.close
    end
  end

end
