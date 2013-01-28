$LOAD_PATH << File.join(File.dirname(__FILE__), '/../../lib')
require 'zippy'
require 'slv'

Before do
  @aruba_timeout_seconds = 60
end

Given /^issue "(.*?)" from archive "(.*?)" doesn't exist in the default archive directory$/ do |issue, year|
  file_name = sprintf("%d-%03d.pdf", year, issue)
  path = File.join(ENV['HOME'], 'slv', file_name)
  if File.exists? path 
    FileUtils.rm path
  end
end

Given /^issue "(.*?)" from archive "(.*?)" doesn't exist in the zip archive$/ do |issue, year|
  zip_file_name = File.join(ENV['HOME'], 'slv', "#{year}.zip")
  if File.exists? zip_file_name
    file_name = sprintf("%d-%03d.pdf", year, issue)
    zip = Zippy.open(zip_file_name)
    zip.delete(file_name) if zip.to_a.include? file_name
  end
end
