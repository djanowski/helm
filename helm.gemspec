Gem::Specification.new do |s|
  s.name = 'helm'
  s.version = '0.0.2'
  s.summary = %{A command-line tool for Lighthouse.}
  s.date = %q{2008-11-06}
  s.author = "Damian Janowski"
  s.email = "damian.janowski@gmail.com"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/helm/commands/assign.rb", "lib/helm/commands/command.rb", "lib/helm/commands/create.rb", "lib/helm/commands/info.rb", "lib/helm/commands/resolve.rb", "lib/helm/lighthouse.rb", "lib/helm/project.rb", "lib/helm/session.rb", "lib/helm.rb", "README.textile", "LICENSE", "Rakefile"]

  s.require_paths = ['lib']

  s.bindir = "bin"
  s.executables = "helm"

  s.add_dependency("choice", "0.1.2")

  s.extra_rdoc_files = ["README.textile"]
  s.has_rdoc = false
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "helm", "--main", "README.textile"]
end

