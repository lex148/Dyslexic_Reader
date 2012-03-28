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
    command = "text2wave -o /dev/stdout .temp.txt | vlc stream:///dev/stdin vlc://quit"
    outputText = `#{command}`
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
