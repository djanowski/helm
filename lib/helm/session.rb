gem 'choice'
require 'choice'

module Helm
  class Session
    attr_reader :options

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

        option :project do
          long '--project'
          short '-p'
          desc 'The project title'
        end
      end

      @options = Choice.choices

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
      ARGV[@params[name].succ]
    end

    def project
      @project ||= Lighthouse::Project.find(:all).detect {|p| p.name == options.project }
    end

    def new_ticket
      Lighthouse::Ticket.new(:project_id => project.id)
    end

    def ticket(id = nil)
      Lighthouse::Ticket.find(id || self[:ticket], :params => {:project_id => project.id})
    end

    def milestone(id = nil)
      if id
        Lighthouse::Milestone.find(id)
      else
        @milestone ||= Lighthouse::Milestone.find(:all, :params => {:project_id => project.id}).detect {|m| m.title == self[:milestone] }
      end
    end

    def user(id = nil)
      if id
        Lighthouse::User.find(id)
      else
        @user ||= Lighthouse::User.find(Lighthouse::Token.find(token).user_id)
      end
    end

    protected

      def account
        @account ||= uri.host.split('.').first
      end
      
      def uri
        @uri ||= URI.parse(url)
      end

      def url
        options.url
      end

      def token
        options.token
      end

      def configure
        Lighthouse.account = account
        Lighthouse.token = token
      end

  end
end
