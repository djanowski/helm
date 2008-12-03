module Helm
  module Commands
    class Info < Command
      def run
        parameters :ticket

        ticket = session.ticket

        puts "##{ticket.id} #{ticket.title}"

        if ticket.description
          puts "=="
          puts ticket.description
        end
      end
    end
  end
end
