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

  binding.pry
  verified_urls = run_verify_urls
  binding.pry

  IRB.start
end


def run_verify_urls
  urls = %w[
    austinchevrolet.not.real
    smith_acura.com/staff
    abcrepair.ca
    hertzrentals.com/review
    londonhyundai.uk/fleet
    http://www.townbuick.net/staff
    http://youtube.com/download
    www.madridinfiniti.es/collision
    www.mitsubishideals.sofake
    www.dallassubaru.com.sofake
    www.quickeats.net/contact_us
    www.school.edu/teachers
    www.www.nissancars/inventory
    www.www.toyotatown.net/staff/management
    www.www.yellowpages.com/business
  ]

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

  binding.pry
  ver_obj = UrlVerifier::RunCurler.new
  binding.pry

  curler_hashes = ver_obj.verify_urls(urls)
  binding.pry

  # ver_obj = UrlVerifier::Verify.new(args)
  # verified_urls = ver_obj.verify_urls(urls)
end
