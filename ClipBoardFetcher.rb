#!/usr/bin/ruby


$LOAD_PATH.unshift "."
require 'gtk2'

source = Gtk::Clipboard.get(Gdk::Selection::CLIPBOARD)
# wait for clipboard content
puts source.wait_for_text.gsub("'","")
