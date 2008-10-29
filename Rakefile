require 'rubygems'
require 'rake/gempackagetask'

GEM_NAME = "Measures"
AUTHOR = "Ted Han"
EMAIL = "gems@skein.us"
HOMEPAGE = "http://github.com/knowtheory/measures"
SUMMARY = "Scientific measurement & unit conversion library."
GEM_VERSION = "0.1"

spec = Gem::Specification.new do |s|
#  s.rubyforge_project = "measures"
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
#  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,test}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install the gem"
task :install do
#  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
#  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
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
  abort "Errors running #{errors.to_sentence}!" if errors.any?
end
namespace :test do
  
  Rake::TestTask.new(:measures) do |t|
    files = FileList['test/measures/*_test.rb']
    t.libs << 'test'
    t.verbose = true
    t.test_files = files.uniq.sort
  end
  
end
