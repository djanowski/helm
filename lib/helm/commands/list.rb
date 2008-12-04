module Helm
  module Commands
    class List < Command
      def run
        parameters :filter

        filter = session[:filter] || "responsible:me state:open milestone:next"

        puts "Tickets with filter \"#{filter}\""
        session.tickets(filter).each do |ticket|
          puts "  ##{ticket.id} #{ticket.title}"
        end
      end
    end
  end
end
