#!/usr/bin/ruby


$LOAD_PATH.unshift "."
require 'gtk2'

source = Gtk::Clipboard.get(Gdk::Selection::CLIPBOARD)

# wait for clipboard content
text = (source.wait_for_text || '')
text = text.split(/[^a-z^0-9^\.^\s]/i).join
#text.strip!
#badchars = %w"\"'\n\r|:"
#badchars.each {|c| text = text.gsub(c,'') }

puts text
