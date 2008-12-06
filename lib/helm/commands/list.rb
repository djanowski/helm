module Helm
  module Commands
    class List < Command
      def run
        parameters :filter

        filter = session[:filter] || "responsible:me state:open milestone:next"

        puts "Tickets with filter \"#{filter}\""
        session.tickets(filter).each do |ticket|
          assignee = ticket.assigned_user_id ?
            find_user(ticket.assigned_user_id).name : "Unassigned"
          puts "  ##{ticket.id} #{ticket.title} (#{assignee})"
        end
      end

      def find_user(id)
        user_id = "user-%s" % id
        cache.get(user_id) || cache.set(user_id, session.user(id))
      end
    end
  end
end
