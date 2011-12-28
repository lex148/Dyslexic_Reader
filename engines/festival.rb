class Festival

  def initialize()
  end

  def read(text)
    stop
    text = clean text
    `rm .temp.txt`
    `touch .temp.txt`
    aFile = File.new(".temp.txt", "w")
    aFile.write(text)
    aFile.close 
    voice = "voice_cmu_us_slt_arctic_hts"
    command = "text2wave -eval \"(#{voice})\" -o /dev/stdout .temp.txt |lame - - | vlc - vlc://quit"
    outputText = `#{command}`
    puts outputText
    if (File.exist? ".temp.wav") == false
      logReadError text
    end
  end

  def stop()
  end

  def clean(text)
    text = text.delete "\""
  end

  def logReadError(text)
    puts "Logging Error"
    filename = "swiftError.log"
    if File.exist? filename
      logfile = File.new(filename, "w")
      logfile.puts "\n\nErrorReading:" + text
    else
      logfile = File.open(filename, "a")
      logfile.puts "\n\nErrorReading:" + text
    end
  end

end
