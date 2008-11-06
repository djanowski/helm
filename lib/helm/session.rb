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

    def project
      @project ||= Lighthouse::Project.find(:all).detect {|p| p.name == options.project }
    end

    def new_ticket
      Lighthouse::Ticket.new(:project_id => project.id)
    end

    def ticket(id = nil)
      Lighthouse::Ticket.find(id || ticket_id, :params => {:project_id => project.id})
    end

    def ticket_id
      ARGV[1].to_i
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
