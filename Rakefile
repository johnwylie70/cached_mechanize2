require "bundler/gem_tasks"

task :console do
  require 'irb'
  require 'irb/completion'
  require 'pp'
  require 'cached_mechanize'

  # Guh::Base.configure do |c|
  #   c.guh_ip_address = ENV['GUH_IP']
  #   c.guh_port = ENV['GUH_PORT']
  # end

  ARGV.clear
  IRB.start
end
