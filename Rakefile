require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'url_verifier'


RSpec::Core::RakeTask.new(:spec)

task :default => :spec
task :test => :spec

###################
task :console do
  require 'irb'
  require 'irb/completion'
  require 'url_verifier'
  require "active_support/all"
  ARGV.clear

  verified_urls = run_verify_urls
  binding.pry

  IRB.start
end


def run_verify_urls
  # urls = %w[https://www.century1chevy.com www.sofake.sofake http://www.mccrea.subaru.com blackwellford.com minooka.subaru.com texarkana.mercedesdealer.com www.bobilya.com hammondautoplex.com www.harbinfordscottsboro.net http://www.lancaster.subaru.com loufusz.subaru.com www.mastro.subaru.com www.muller.subaru.com reinekefamilydealerships.com]

  urls = %w[blackwellford.com/staff www.mccrea.subaru.com/inventory www.sofake.sofake https://www.century1chevy.com https://www.mccreasubaru.com]

  args = { timeout_limit: 60 }
  ver_obj = UrlVerifier::RunCurler.new(args)
  curler_hashes = ver_obj.verify_urls(urls)
end
