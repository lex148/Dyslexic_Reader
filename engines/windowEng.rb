class WindowEng

  def initialize()
  end

  def read(text)
    text = clean text
    puts text
	command = "notepad.exe"
    @readerProssess = IO.popen command
	puts command
  end

  def stop()
    puts "windowEng stop"
    if(@readerProssess != nil and @readerProssess.closed? == false)
	  command = "kill " + (@readerProssess.pid).to_s
	  IO.popen command
      @readerProssess.close
	end
  end

  def clean(text)
	text = text.delete "\""
  end

end

