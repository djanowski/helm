module Helm
  module Commands
    class Show < Command
      def run
        parameters :milestone

        if milestone = session.milestone
          puts "Details about #{milestone.title}"
          puts "  Goals:   #{milestone.goals}"
          puts "  Tickets: #{milestone.open_tickets_count} open out of #{milestone.tickets_count}"
          puts "  Due on:  #{milestone.due_on}"
        else
          puts "The milestone \"#{session[:milestone]}\" couldn't be found"
        end
      end
    end
  end
end
