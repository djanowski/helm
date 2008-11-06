module Helm
  module Commands
    class Command
      attr_reader :session
      
      def initialize(session)
        @session = session
      end
    end
  end
end
