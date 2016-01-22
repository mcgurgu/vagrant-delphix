
require 'bundler/gem_helper'

# Change to the directory of this file.
Dir.chdir(File.expand_path("../", __FILE__))

namespace :gem do
  Bundler::GemHelper.install_tasks
end

task :test => [:up, :halt, :destroy] do
end

task :up do
  sh 'bash test/rake_test_up.sh'
end

task :halt do
  sh 'bash test/rake_test_halt.sh'
end

task :destroy => [:halt] do
  sh 'bash test/rake_test_destroy.sh'
end
