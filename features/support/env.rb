require 'aruba/cucumber'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s

  # we use fake home dir for testing
  @real_home = ENV['HOME']
  fake_home = File.join('/tmp', 'fake_home')
  unless File.exists? fake_home
    FileUtils.mkdir fake_home
  else
    FileUtils.rm_rf File.join(fake_home, '*'), :secure => true
  end
  ENV['HOME'] = fake_home
end

After do
  ENV['RUBYLIB'] = @original_rubylib
  ENV['HOME'] = @real_home
end
