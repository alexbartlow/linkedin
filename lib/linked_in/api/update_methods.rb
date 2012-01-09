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

        hsh = {
          'recipients' => {
            'values' => recipient_ids.map {|rec_id|
              {'person' => {'_path' => "/people/#{rec_id}"}}
            }
          },
          "subject" => subject,
          "body"    => body
        }
        post(path, hsh.to_json, "Content-Type" => "application/json").code
      end
    end
  end
end

