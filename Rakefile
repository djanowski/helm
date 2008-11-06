require 'rake'
require 'rake/gempackagetask'
require 'rake/clean'
require 'spec/rake/spectask'

gem_spec_file = 'helm.gemspec'

gem_spec = eval(File.read(gem_spec_file)) rescue nil

Rake::GemPackageTask.new(gem_spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
  rm_f FileList['pkg/**/*.*']
end if gem_spec

task :default => :spec

desc "Run all specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Generate the gemspec file."
task :gemspec do
  require 'erb'

  File.open(gem_spec_file, 'w') do |f|
    f.write ERB.new(File.read("#{gem_spec_file}.erb")).result(binding)
  end
end
