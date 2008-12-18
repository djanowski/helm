module Helm
  module Commands
    class Schedule < Command
      def run
        parameters :ticket, :milestone

        ticket = session.ticket

        current_milestone = session.milestone(ticket.milestone_id)

        ticket.milestone_id = session.milestone.id

        if ticket.save
          puts format.ticket_change(ticket, :milestone, current_milestone, session.milestone)
        end
      end
    end
  end
end
