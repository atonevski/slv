
Given /^the archive "(.*?)" doesn't exist in the default arhive directory$/ do |year|
  arc = File.join(ENV['HOME'], 'slv', "#{year}.zip")
  FileUtils.rm(arc) if File.exists? arc
end
