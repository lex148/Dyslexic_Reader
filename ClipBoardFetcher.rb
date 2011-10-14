#!/usr/bin/ruby


$LOAD_PATH.unshift "."
require 'gtk2'

source = Gtk::Clipboard.get(Gdk::Selection::CLIPBOARD)
badchars = %w"' ’ – ? …"

# wait for clipboard content
text = source.wait_for_text

badchars.each do |c|
  text = text.gsub(c, "")
end

#for debuging log the clipboard
#open('clipboard.log', 'a') { |f|
#  f.puts text
#}

puts text
