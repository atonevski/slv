# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','slv','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name          = 'slv'
  s.version       = SLV::VERSION
  s.author        = 'Andreja Tonevski'
  s.email         = 'atonevski@gmail.com'
  s.homepage      = 'http://your.website.com'
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'SLV RM Gazette pdf grep tool'  
  s.description   = %q{SLV allows you to grep search RM Gazette free pdf issues. You can archive bundles of pdfs and do more.}
  
  # Add your other files here if you make them
  s.files = %w(
    bin/slv
    lib/slv/version.rb
    lib/slv.rb
    lib/slv/app.rb
    lib/slv/http.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','slv.rdoc']
  s.rdoc_options << '--title' << 'slv' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'slv'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.5.3')
  s.add_dependency('zippy')
  s.add_dependency('rainbow')
end
