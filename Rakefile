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

  # array_of_urls = %w[https://www.century1chevy.com blackwellford.com/staff www.mccrea.subaru.com/inventory www.sofake.sofake https://www.mccreasubaru.com]

  array_of_urls = %w[https://www.century1chevy.com]
  # array_of_urls = %w[blackwellford.com/staff]
  # array_of_urls = %w[https://www.sofake.sofake]


  args = { timeout_limit: 60 }
  verifier = UrlVerifier::RunCurler.new(args)
  verified_url_hashes = verifier.verify_urls(array_of_urls)
end
