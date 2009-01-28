module Helm
  module Commands
    class Open < Command
      def run
        parameters :ticket

        system "open #{session.url}/projects/#{session.project_id}/tickets/#{session[:ticket]}"
      end
    end
  end
end
