Gem::Specification.new do |s|
  s.name = 'helm'
  s.version = '0.0.1'
  s.summary = %{helm}
  s.description = %{A command-line tool for Lighthouse.}
  s.author = "Damian Janowski"
  s.email = "damian.janowski@gmail.com"
  #s.homepage = ""

  #s.test_files = FileList['test/**/*']

  s.files = FileList['bin/**', 'lib/**/*.rb', 'README', 'doc/**/*.*']

  s.require_paths << 'lib'
  
  FileList['lib/**'].inject(s.require_paths) do |require_paths,path|
    require_paths << path if File.directory?(path) && !require_paths.include?(path)
    require_paths
  end

  s.require_paths.uniq!
  
  s.bindir = "bin"
  s.executables = "helm"
  #s.default_executable = ""
  s.add_dependency("choice", "0.1.2")
  #s.add_dependency("", "")
  #s.extensions << ""
  #s.extra_rdoc_files = ["README"]
  #s.has_rdoc = true
  #s.platform = "Gem::Platform::Ruby"
  #s.required_ruby_version = ">= 1.8.5"
  #s.requirements << "An ice cold beer."
  #s.requirements << "Some free time!"
  #s.rubyforge_project = "helm"
end
