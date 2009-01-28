gem 'choice'
require 'choice'

module Helm
  class Session
    attr_reader :options
    attr_reader :cache

    def initialize
      Choice.options do
        option :url do
          long '--url'
          desc 'The project URL'
        end

        option :token do
          long '--token'
          desc 'The token to authenticate against the server'
        end

        option :username do
          long '--username'
          desc 'The username to authenticate against the server'
        end

        option :password do
          long '--password'
          desc 'The username to authenticate against the server'
        end

        option :project do
          long '--project'
          short '-p'
          desc 'The project title'
        end
      end

      @options = Choice.choices
      @cache = Drawer.open!('~/.helm/cache')

      configure
    end

    # Configure the set of params to be used by the active command.
    def configure_params(*names)
      @params = {}
      names.each_with_index do |name, index|
        @params[name] = index
      end
    end

    # Access positional parameters sent to the active command
    # based on the order specified in configure_params.
    def [](name)
      arguments[@params[name].succ]
    end

    def project
      @project ||= Lighthouse::Project.find(project_id)
    end

    def project_id
      cache.get("#{url}---#{options.project}") do
        @project = Lighthouse::Project.find(:all).detect {|p| p.name == options.project }
        @project.id
      end
    end

    def new_ticket
      Lighthouse::Ticket.new(:project_id => project.id)
    end

    def ticket(id = nil)
      Lighthouse::Ticket.find(id || self[:ticket], :params => {:project_id => project.id})
    end

    def tickets(filter = nil)
      project.tickets(:q => filter)
    end

    def milestone(*args)
      # TODO: ugly

      if args.empty?
        milestone_by_title(self[:milestone])
      elsif args.first.nil?
        nil
      elsif args.first.to_i.to_s == args.first.to_s
        Lighthouse::Milestone.find(args.first, :params => {:project_id => project.id})
      else
        milestone_by_title(args.first)
      end
    end

    def milestone_by_title(title)
      title = title.to_s

      Lighthouse::Milestone.find(:all, :params => {:project_id => project.id}).detect {|m| m.title == title }
    end

    def user(id = nil)
      if id
        Lighthouse::User.find(id)
      else
        @user ||= Lighthouse::User.find(Lighthouse::Token.find(token).user_id)
      end
    end

    def uri
      @uri ||= URI.parse(url)
    end

    def url
      options.url
    end

    def username
      options.username
    end

    def password
      options.password
    end

    def ticket_path(id = nil)
      Lighthouse::Ticket.element_path(id || self[:ticket], {:project_id => project.id}).sub(/\.xml$/, '')
    end

    protected

      def account
        @account ||= uri.host.split('.').first
      end
      
      def token
        options.token
      end

      def configure
        Lighthouse.account = account
        Lighthouse.token = token
      end

      def arguments
        @arguments ||= ARGV.select do |argv|
          argv !~ /^--/
        end
      end
  end
end
