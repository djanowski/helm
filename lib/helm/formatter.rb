module Helm
  class Formatter
    def ticket_number(ticket)
      "##{ticket.id}".rjust(4)
    end

    def ticket_with_title(ticket)
      "#{ticket_number(ticket)} #{ticket.title}"
    end

    def ticket_change(ticket, attribute, old_value, new_value)
      "#{ticket_number(ticket)} #{attribute} changed: #{old_value || '(none)'} => #{new_value}"
    end
  end
end
