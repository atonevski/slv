When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

# Add more step definitions here

Then /^archive directory should exist in my home directory$/ do
   Dir.exists?(File.join(ENV['HOME'], 'slv')).should be_true
end

