require 'rake'
require 'rake/gempackagetask'
require 'rake/clean'
require 'spec/rake/spectask'
require 'spec/translator'

gem_spec = Gem::Specification.new do |s|
  s.name = 'boat'
  s.version = '0.0.1'
  s.summary = %{boat}
  s.description = %{}
  s.author = "Damian Janowski"
  s.email = "damian.janowski@gmail.com"
  #s.homepage = ""

  #s.test_files = FileList['test/**/*']

  s.files = FileList['lib/**/*.rb', 'README', 'doc/**/*.*']
  s.require_paths << 'lib'
  
  FileList['lib/**'].inject(s.require_paths) do |require_paths,path|
    require_paths << path if File.directory?(path) && !require_paths.include?(path)
    require_paths
  end

  s.require_paths.uniq!
  
  #s.bindir = "bin"
  #s.executables = "boat"
  #s.default_executable = ""
  #s.add_dependency("", "")
  #s.add_dependency("", "")
  #s.extensions << ""
  #s.extra_rdoc_files = ["README"]
  #s.has_rdoc = true
  #s.platform = "Gem::Platform::Ruby"
  #s.required_ruby_version = ">= 1.8.5"
  #s.requirements << "An ice cold beer."
  #s.requirements << "Some free time!"
  #s.rubyforge_project = "boat"
end

Rake::GemPackageTask.new(gem_spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
  rm_f FileList['pkg/**/*.*']
end

task :default => :spec

desc "Run all specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end
