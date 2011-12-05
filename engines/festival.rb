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
    command = "text2wave -eval \"(#{voice})\" -o .temp.wav .temp.txt\n"
    #command = "echo \"" + text + "\" | text2wave -o .temp.wav \n"
    # this is blocking, wait for wav file to be created
    outputText = `#{command}`
    puts outputText
    #IO.popen command
    #readStr = "vlc .temp.wav vlc://quit"
    readStr = "cvlc .temp.wav vlc://quit"
    puts readStr
    @readerProssess = IO.popen readStr

  if (File.exist? ".temp.wav") == false
      logReadError text
  end
  end

  def stop()
    if(@readerProssess != nil and @readerProssess.closed? == false)
    command = "kill " + (@readerProssess.pid).to_s
    # this is blocking, wait for wav player to be killed
    outputText = `#{command}`
    puts outputText
  end 
  puts "Festival stop"
  if File.exist? ".temp.wav"
    puts "delete .temp.wav"
    File.delete ".temp.wav"
  end 
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
