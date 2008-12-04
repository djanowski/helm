module Helm
  module Commands
    class Show < Command
      def run
        parameters :milestone, :filter

        unless milestone = session.milestone
          return puts("The milestone \"#{session[:milestone]}\" couldn't be found")
        end

        filter = session[:filter] || "state:open milestone:\"#{milestone.title}\""

        puts "Details about #{milestone.title}"
        puts "  Goals:   #{milestone.goals}"
        puts "  Due on:  #{milestone.due_on}"
        puts ""
        puts "  Tickets (#{milestone.open_tickets_count} open out of #{milestone.tickets_count})"

        session.tickets(filter).each do |ticket|
          puts "  ##{ticket.id} #{ticket.title}"
        end
      end
    end
  end
end
