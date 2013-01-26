$LOAD_PATH << File.join(File.dirname(__FILE__), '/../../lib')
require 'zippy'
require 'slv'

Before do
  @aruba_timeout_seconds = 60
end

Given /^the directory "(.*?)" does not exists in the home directory$/ do |dir|
  if Dir.exists? File.join(ENV['HOME'], dir)
    FileUtils.rm_rf File.join(ENV['HOME'], dir)
  end
end

Then /^"(.*?)" directory should exist in my home directory$/ do |dir|
  Dir.exists?(File.join ENV['HOME'], dir).should be_true
end


Given /^issue "(.*?)" does not exists in archive "(.*?)"$/ do |issue, year|
  zip_file_name = File.join(ENV['HOME'], 'slv', "#{year}.zip")
  if File.exists? zip_file_name
    file_name = sprintf("%d-%03d.pdf", year, issue)
    zip = Zippy.open(zip_file_name)
    zip.delete(file_name) if zip.to_a.include? file_name
  end
end

Given /^issue "(.*?)" does exists in archive "(.*?)"$/ do |issue, year|
  zip_file_name = File.join(ENV['HOME'], 'slv', "#{year}.zip")
  file_name = sprintf("%d-%03d.pdf", year, issue)

  zip = if File.exists? zip_file_name
          Zippy.open(zip_file_name)
        else
          Zippy.create(zip_file_name)
        end
  http  = SLV::HTTP.new(SLV::HOST)
  zip[file_name] = http.get_issue(issue, year)
end

Then /^issue "(.*?)" from archive "(.*?)" exists in the default archive directory$/ do |issue, year|
  file_name = sprintf("%d-%03d.pdf", year, issue)
  File.exist?(File.join(ENV['HOME'], 'slv', file_name)).should be_true
end

Then /^the list of archive "(.*?)" should contain "(.*?)" issues$/ do |year, total|
  all_output.split("\n").size.should == total.to_i
end


Given /^issues "(.*?)"\-"(.*?)" for archive "(.*?)" do not exist in the default archive directory$/  do |from, to, year|
  
  (from .. to).each do |issue| 
    file_name = sprintf("%d-%03d.pdf", year, issue) 
    path = File.join(ENV['HOME'], 'slv', file_name)
    FileUtils.rm(path) if File.exists? path
  end
end

Then /^issues "(.*?)"\-"(.*?)" for archive "(.*?)" have prefix "(.*?)"$/ do |from, to, year, prefix|
  (from .. to).each do |issue|
    file_name = sprintf("%d-%03d.pdf", year, issue)
    all_output.index("#{prefix}#{file_name}").should_not be_nil
  end
end
