module Lighthouse
  class Ticket < Base
    def body
      attributes['body'] ||= ''
    end

    def body=(value)
      attributes['body'] = value
    end
  end
end

module Helm
  module Commands
    class Create < Command
      def run
        ticket = nil

        while line = $stdin.gets
          line.strip!

          if line.empty?
            save(ticket)
            ticket = nil
            next
          end

          if ticket.nil?
            ticket = session.new_ticket
            ticket.title = line
          else
            unless line.empty?
              ticket.body << line
              ticket.body << "\n"
            end
          end
        end

        save(ticket)
      end

      protected

        def save(ticket)
          return unless ticket
          ticket.title = ticket.title.sub(/^- ?/, '')
          ticket.title = ticket.title.sub(/\.$/, '')
          ticket.body = ticket.body.strip
          ticket.save
          puts "##{ticket.id} Created"
        end
    end
  end
end
