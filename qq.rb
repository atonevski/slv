#! /usr/bin/env ruby
# encoding: utf-8


require 'pdf/reader'


FILE_NAME = '/home/and/slv/2012-074.pdf'
RE = /број\s+74/i
buf = ''
File.open(FILE_NAME, 'rb') { |f| buf = f.read }

StringIO.open(buf, 'rb') do |io|
  reader = PDF::Reader.new(io)
  pg = []
  reader.pages.each do |page|
    pg << page.number if page.text =~ RE
  end
  puts "matches: #{pg.join(', ')}"
  puts "total pages: #{reader.page_count}"
end

