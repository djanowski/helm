module Helm
  module Commands
    class Upload < Command
      def run
        parameters :ticket, :filename

        ensure_filename!

        login!

        agent.get url(session.ticket_path(ticket)) do |page|
          form = page.form_with(:enctype => 'multipart/form-data')

          form.file_uploads.first.file_name = filename

          agent.submit(form)
        end
      end

      protected

        def filename
          session[:filename]
        end

        def ticket
          session[:ticket]
        end

        def url(path)
          "#{session.url}#{path}"
        end

        def login!
          agent.get url('/login') do |page|
            page.forms.first['email']     = session.username
            page.forms.first['password']  = session.password

            agent.submit(page.forms.first)
          end
        end

        def agent
          @agent ||= begin
                       require 'mechanize'
                       WWW::Mechanize.new # { |a| require 'logger'; a.log = Logger.new($stdout) }
                     end
        end

        def ensure_filename!
          raise "File not found - #{filename}" unless File.exist?(filename)
        end
    end
  end
end
