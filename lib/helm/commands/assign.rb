module Helm
  module Commands
    class Assign < Command
      def run
        ticket = session.ticket

        if session.milestone
          ticket.milestone_id = session.milestone.id
          
          if ticket.save
            puts "##{ticket.id} Milestone changed: #{session.milestone || '(none)'} => #{session.milestone}"
          end
        else
          new_assignee = session.user

          assignee = session.user(ticket.assigned_user_id) if ticket.assigned_user_id

          unless ticket.assigned_user_id && ticket.assigned_user_id == new_assignee.id
            ticket.assigned_user_id = new_assignee.id

            if ticket.save
              puts "##{ticket.id} Assigned user changed: #{assignee || '(none)'} => #{new_assignee}"
            end
          end
        end
      end
    end
  end
end
