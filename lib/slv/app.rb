# encoding: utf-8

require 'pdf/reader'

module SLV
  ARC_DIR    = File.join(ENV['HOME'], 'slv')
  EMAIL_ADDR = 'atonevski@gmail.com'

  def SLV.grep(o, re)
    io = nil
    if o.is_a?(String) # either filename or string buffer
      if o =~ /\.pdf$/
        io = File.open(o, 'rb')
      else
        io = StringIO.new(o, 'rb')
      end
    elsif o.is_a?(StringIO) or o.class < IO
      io = o
    else
      raise "grep: invalid argument #{o.class}"
    end

    reader = PDF::Reader.new(io)
    results = []
    reader.pages.each do |page|
      results << page.number if page.text =~ re
    end
    results = nil if results.size == 0
    results
  end
end
