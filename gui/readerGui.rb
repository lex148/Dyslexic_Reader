#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'libglade2'
#require 'reader.rb'

class DyslexicReaderGlade
  include GetText

  attr :glade
  attr :reader
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}
    @reader = Reader.new
	@reader.mainTextArea @glade["txtToRead"]
	@reader.watch(true)
  end
  
  def on_cbWatch_toggled(widget)
	if @reader
      theText = @glade["cbWatch"].active?
      @reader.watch theText
	end
    #puts "on_cbWatch_toggled() is not implemented yet."
  end

  def on_reader_destroy(widget)
    GTK.main_quit	
  end

  def on_cmdRead_clicked(widget)
    if @reader
      theText = @glade["txtToRead"].buffer.text
      @reader.read theText
	end
  end

  def on_cmdSetup_clicked(widget)
    if @reader
	  @reader.setup
	end
  end

  def on_cmdStop_clicked(widget)
    if @reader
	  @reader.stop
	end
  end

end


