#!/usr/bin/env rake
require "rubygems"
require "bundler/setup"
require "coveralls"
require "bundler/gem_tasks"
require "rake/clean"
require "rake/testtask"
require "standard/rake"

task default: [:test, :standard]

Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << "lib"
  t.pattern = "test/*_test.rb"
end

namespace :test do
  Dir.glob("gemfiles/*.gemfile").each do |gemfile|
    name = /gemfiles\/(.*).gemfile/.match(gemfile)[1]
    desc "Run #{name} tests"
    task name do |rake_task|
      gemfile_name = rake_task.name.split(":").last
      puts "Starting #{gemfile_name} tests..."
      sh "bundle --gemfile=gemfiles/#{gemfile_name}.gemfile && bundle exec rake test"
    end
  end
end

desc "Run all tests and get merged test coverage"
task :tests do
  Dir.glob("gemfiles/*.gemfile").each do |gemfile|
    Bundler.with_original_env do
      puts "Starting #{gemfile} tests..."
      sh "bundle --gemfile=#{gemfile} && bundle exec rake test"
    end
  end
  Coveralls.push!
end

desc "Run simple benchmarks"
task :bench do
  current_commit = `git rev-parse HEAD`
  file_name = "benchmarks/#{Time.now.strftime "%Y%m%d"}-benchmark.log"
  exec "echo -e 'Data for commit: #{current_commit}' > #{file_name} && ruby test/bench.rb >> #{file_name}"
end

# ROCCO ===============================================================

begin
  require "rdiscount"
rescue LoadError => e
  warn e.inspect
end
begin
  require "rocco/tasks"
  Rocco.make "docs/"
rescue LoadError => e
  warn e.inspect
end

desc "Build rocco docs"
task docs: :rocco
directory "docs/"

desc "Build docs and open in browser for the reading"
task read: :docs do
  sh "open docs/lib/m.html"
end

# Make index.html a copy of rocco.html
file "docs/index.html" => "docs/lib/m.html" do |_f|
  cp "docs/lib/m.html", "docs/index.html", preserve: true
end

task docs: "docs/index.html"
CLEAN.include "docs/index.html"

# Alias for docs task
task doc: :docs

# GITHUB PAGES ===============================================================

desc "really kill docs folder"
task :clean_docs do
  sh "rm -rf docs/"
end

desc "Update gh-pages branch"
task pages: [:clean_docs, "docs/.git", :docs] do
  rev = `git rev-parse --short HEAD`.strip
  Dir.chdir "docs" do
    sh "mv lib/m m"
    sh "mv lib/m.html m.html"
    sh "git add -A"
    sh "git commit -m 'rebuild pages from #{rev}'" do |ok, _res|
      if ok
        verbose { puts "gh-pages updated" }
        sh "git push -q o HEAD:gh-pages"
      end
    end
  end
end

# Update the pages/ directory clone
file "docs/.git" => ["docs/"] do |f|
  sh "cd docs && git init -q && git remote add o ../.git" unless File.exist? f.name
  sh "cd docs && git fetch -q o && git reset -q --hard o/gh-pages && git rm -r . && git commit -m 'blank out' && touch ."
end
CLOBBER.include "docs/.git"
