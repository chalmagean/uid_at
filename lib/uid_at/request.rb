module UidAt
  class Request

    attr_accessor :session_id

    def perform(uid, client,options={})
      response = client.request("uid", "uidAbfrageServiceRequest") do |r|
        r.body = {
          "uid:tid"    => UidAt.subscriber_id,
          "uid:benid"  => UidAt.user_id,
          "uid:id"     => session_id,
          "uid:uid_tn" => UidAt.uid_tn,
          "uid:uid"    => uid,
          "uid:stufe"  => "2"
        }
      end.to_hash[:uid_abfrage_service_response]
      options[:details] ? response : response[:rc] == "0"
    end

    def login(client)
      self.session_id = client.request("ses", "loginRequest") do |r|
        r.body = {
          "ses:tid"          => UidAt.subscriber_id,
          "ses:benid"        => UidAt.user_id,
          "ses:pin"          => UidAt.pin,
          "ses:herstellerid" => UidAt.subscriber_id
        }
      end.to_hash[:login_response][:id]
    end

    def logout(client)
      req = client.request("ses", "logoutRequest") do |r|
        r.body = {
          "ses:tid"   => UidAt.subscriber_id,
          "ses:benid" => UidAt.user_id,
          "ses:id"    => self.session_id
        }
      end.to_hash[:logout_response][:rc] == "0"
    end

  end
end
