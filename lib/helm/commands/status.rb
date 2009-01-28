module Helm
  module Commands
    class Status < Command
      def run
        parameters :ticket, :status

        ticket = session.ticket

        old_status, new_status = ticket.state, session[:status]

        unless old_status == new_status
          ticket.state = new_status

          if ticket.save
            puts format.ticket_change(ticket, :status, old_status, new_status)
          end
        end
      end
    end
  end
end
