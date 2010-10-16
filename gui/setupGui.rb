#!/usr/bin/env ruby
#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'libglade2'

class SetupGlade
  include GetText

  attr :setup
  attr :glade
  
  def initialize(engList, setup, path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}
    @glade["cbEngs"].focus_on_click=true
	engList.each { |eng| @glade["cbEngs"].append_text eng }
	@glade["cbEngs"].active = 0
	@setup = setup
  end
  
  
  
  

  def on_setup_destroy(widget)
  end
  
  def on_cmdCancel_clicked(widget)      
    @glade["setup"].destroy    
  end
  
  def on_cmdOk_clicked(widget)
    if @setup   
      engComboBox = @glade["cbEngs"] 
      @setup.saveEngine engComboBox.active_text
    end
    @glade["setup"].destroy
  end
  
end



# Main program
#if __FILE__ == $0
#  # Set values as your own application. 
#  PROG_PATH = "setup.glade"
#  PROG_NAME = "YOUR_APPLICATION_NAME"
#  SetupGlade.new(nil,nil,PROG_PATH, nil, PROG_NAME)
#  Gtk.main
#end
