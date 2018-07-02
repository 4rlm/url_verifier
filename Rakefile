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

  IRB.start
end


def run_verify_urls

  urls = %w[minooka.subaru.com texarkana.mercedesdealer.com http://www.mccrea.subaru.com blackwellford.com www.bobilya.com https://www.century1chevy.com hammondautoplex.com www.harbinfordscottsboro.net http://www.lancaster.subaru.com loufusz.subaru.com www.mastro.subaru.com www.muller.subaru.com reinekefamilydealerships.com]

  # webs_obj = UrlVerifier::Webs.new(WebsCriteria.all_scrub_web_criteria)
  # args = {
  #   dj_on: false,
  #   dj_count_limit: 0,
  #   dj_workers: 3,
  #   obj_in_grp: 10,
  #   dj_refresh_interval: 10,
  #   db_timeout_limit: 120,
  #   cut_off: 10.days.ago
  # }

  ver_obj = UrlVerifier::RunCurler.new
  curler_hashes = ver_obj.verify_urls(urls)
end
