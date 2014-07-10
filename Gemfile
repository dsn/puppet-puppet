source "https://rubygems.org"

gem 'rake'
gem 'json_pure'
gem 'puppet-lint'
gem 'rspec', '< 3.0.0'
gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git'
gem 'puppetlabs_spec_helper'

if puppetversion = ENV['PUPPET_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end