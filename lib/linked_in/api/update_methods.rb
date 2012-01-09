require 'builder'
module LinkedIn
  module Api

    module UpdateMethods

      def add_share(share)
        path = "/people/~/shares"
        defaults = {:visibility => {:code => "anyone"}}
        post(path, defaults.merge(share).to_json, "Content-Type" => "application/json")
      end

      # def share(options={})
      #   path = "/people/~/shares"
      #   defaults = { :visability => 'anyone' }
      #   post(path, share_to_xml(defaults.merge(options)))
      # end
      #
      # def update_comment(network_key, comment)
      #   path = "/people/~/network/updates/key=#{network_key}/update-comments"
      #   post(path, comment_to_xml(comment))
      # end
      #
      # def update_network(message)
      #   path = "/people/~/person-activities"
      #   post(path, network_update_to_xml(message))
      # end
      #
      #
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
        post(path, xml.target!).code
      end
      #
      # def clear_status
      #   path = "/people/~/current-status"
      #   delete(path).code
      # end
      #

    end

  end
end
