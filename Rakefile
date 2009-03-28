require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'

GEM = "measures"
GEM_VERSION = "0.0.1"
AUTHOR = "Ted Han"
EMAIL = "measures@knowtheory.net"
HOMEPAGE = "http://measures.knowtheory.net" #doesn't exist yet :P
SUMMARY = "A minimally invasive measurement library"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  
  # Uncomment this to add a dependency
  # s.add_dependency "foo"
  
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,test}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

require 'rake/testtask'
desc 'Default: run test::unit examples'
task :default => :test
task :test do
  errors = %w(test:measures).collect do |task|
    begin
      Rake::Task[task].invoke
      nil
    rescue => e
      task
    end
  end.compact
  abort "Errors running #{errors}!" if errors.any?
end
namespace :test do
  
  Rake::TestTask.new(:measures) do |t|
    files = FileList['test/measures/*_test.rb']
    t.libs << 'test'
    t.verbose = true
    t.test_files = files.uniq.sort
  end
  
end