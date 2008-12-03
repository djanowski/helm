module Helm
  module Commands
    class Command
      attr_reader :session
      
      def parameters(*names)
        session.configure_params(*names)
      end

      def initialize(session)
        @session = session
      end
    end
  end
end
