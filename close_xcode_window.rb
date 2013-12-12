#!/usr/bin/ruby
require 'rubygems'
begin
  require 'appscript'
  include Appscript   # note the lack of quotes
rescue LoadError
  puts "Appscript gem must be installed.\nPlease run $ gem install rb-appscript"
  exit
end

app('Xcode').windows[0].close   # closes the window