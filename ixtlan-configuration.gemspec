# -*- mode: ruby -*-
Gem::Specification.new do |s|
  s.name = 'ixtlan-configuration'
  s.version = '0.2.2'

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
  s.add_runtime_dependency 'cuba-api', '~> 0.5'
  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_development_dependency 'ixtlan-audit'
  s.add_development_dependency 'ixtlan-error-handler'
  s.add_development_dependency 'ixtlan-remote'
  s.add_development_dependency 'ixtlan-gettext'
  s.add_development_dependency 'ixtlan-user-management'
  DM_VERSION = '~>1.2'
  s.add_development_dependency 'dm-timestamps', DM_VERSION
  s.add_development_dependency 'dm-migrations', DM_VERSION  
  s.add_development_dependency 'dm-validations', DM_VERSION
  s.add_development_dependency 'dm-sqlite-adapter', DM_VERSION
end

# vim: syntax=Ruby
