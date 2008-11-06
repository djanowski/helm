module Helm
  module Commands
    class Assign < Command
      def run
        ticket, new_assignee = session.ticket, session.user

        assignee = session.user(ticket.assigned_user_id) if ticket.assigned_user_id

        unless ticket.assigned_user_id && ticket.assigned_user_id == new_assignee.id
          ticket.assigned_user_id = new_assignee.id

          if ticket.save
            puts "##{ticket.id} Assigned user changed: #{assignee || '(none)'} => #{new_assignee.name}"
          end
        end
      end
    end
  end
end
