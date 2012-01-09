require 'builder'
module LinkedIn
  module Api
    module UpdateMethods
      def add_share(share)
        path = "/people/~/shares"
        defaults = {:visibility => {:code => "anyone"}}
        post(path, defaults.merge(share).to_json, "Content-Type" => "application/json")
      end

      def send_message(subject, body, *recipient_ids)
        path = "/people/~/mailbox"

        xml = Builder::XmlMarkup.new
        xml.send('mailbox-item') do
          xml.recipients do
            recipient_ids.each do |rec_id|
              xml.recipient do
                xml.person('path' => "/people/#{rec_id}")
              end
            end
          end
          xml.subject do
            xml.text! subject
          end
          xml.body do
            xml.text! body
          end
        end
        post(path, xml.target!, 'Content-Type' => "application/xml").code
      end
    end
  end
end

