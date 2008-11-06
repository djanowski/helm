require 'uri'
require 'lib/lighthouse'

module Helm
  class Project
    attr_accessor :url, :title, :token

    def initialize(url)
      @url = url
    end

    protected

      def account
        @account ||= uri.host.split('.').first
      end
      
      def uri
        @uri ||= URI.parse(url)
      end

      def configure
        Lighthouse.account = account
        Lighthouse.token = token
      end

  end
end
