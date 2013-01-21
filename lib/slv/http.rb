# encoding: utf-8

require 'net/http'
require 'uri'

module SLV
  HOST = 'www.slvesnik.com.mk'
  class HTTP

    attr_accessor :host

    def initialize(host=HOST)
      @host = host
      @http = Net::HTTP.new(host)
      raise "HTTP error: cann't connect to host '#{@host}'" unless @http
    end
    
    # returns pdf
    def get_issue(year, issue)
      path = "/besplatni-izdanija.nspx?pYear=#{year}"
      response = @http.get(path)
      html = ''
      if response.code == '200'
        html = response.body.force_encoding('utf-8')
      else
        raise "error opening free issue page: #{response.code} #{response.message}"
      end

      # get link tag
      re = %r{<a ([^>]*?)>\s*СЛУЖБЕН ВЕСНИК НА РМ бр.\s*#{issue}\s*</a>}i
      return nil if html !~ re

      attribs = Regexp.last_match[1]
      re = %r{href\s*=\s*"([^"]*)"}
      attribs =~ re
      link = Regexp.last_match[1].dup
      uri = URI.parse(link)
      http = Net::HTTP.new(uri.host)
      response = http.get(uri.path)
      if response.code == '200'
        return response.body.dup
      else
        return nil
      end
    end

    # returns arr of issues uris
    def issues_for(year)
      path = "/besplatni-izdanija.nspx?pYear=#{year}"
      response = @http.get(path)
      html = ''
      if response.code == '200'
        html = response.body.force_encoding('utf-8')
      else
        raise "error opening free issue page: #{response.code} #{response.message}"
      end
     
      results = []
      # get link tag
      re = %r{<a\s+href\s*=\s*"([^"]*)"[^>]*?>\s*СЛУЖБЕН ВЕСНИК НА РМ бр.\s*(\d+)}i
      pos = 0
      while html.index(re, pos)
        results[Regexp.last_match[2].to_i] = Regexp.last_match[1].dup
        pos = Regexp.last_match.end(2).to_i
      end

      return nil if results.size == 0
      results
    end

  end
end
