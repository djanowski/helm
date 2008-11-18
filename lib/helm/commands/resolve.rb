module Helm
  module Commands
    class Resolve < Command
      def run
        ticket = session.ticket

        ticket.state = 'resolved'
        
        if ticket.save
          puts "##{ticket.id} Resolved"
        end
      end
    end
  end
end
