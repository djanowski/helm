module Helm
  module Commands
    class Command
      attr_reader :session

      def cache
        session.cache
      end
      
      def parameters(*names)
        session.configure_params(*names)
      end

      def initialize(session)
        @session = session
      end

      def format
        @formatter ||= Helm::Formatter.new
      end
    end
  end
end
