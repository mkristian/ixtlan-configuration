# -*- mode: ruby -*-
Gem::Specification.new do |s|
  s.name = 'ixtlan-configuration'
  s.version = '0.1.0'

  s.summary = 'configuration for other ixtlan-xyz wth serializer, input-filter and cuba definition'
  s.description = s.summary
  s.homepage = 'http://github.com/mkristian/ixtlan-configuration'

  s.authors = ['Christian Meier']
  s.email = ['m.kristian@web.de']

  s.files = Dir['MIT-LICENSE']
  s.licenses << 'MIT'
#  s.files += Dir['History.txt']
  s.files += Dir['README.md']
  s.rdoc_options = ['--main','README.md']
  s.files += Dir['lib/**/*']
  s.files += Dir['spec/**/*']
  s.test_files += Dir['spec/**/*_spec.rb']
  s.add_development_dependency 'slf4r', '~> 0.4.2'
end

# vim: syntax=Ruby
