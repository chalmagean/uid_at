module UidAt
  class Request

    attr_accessor :session_id

    def perform(uid, client)
      client.request("uid", "uidAbfrageRequest") do |r|
        r.body = {
          "uid:sessionid" => session_id,
          "uid:tid"   => UidAt.subscriber_id,
          "uid:benid" => UidAt.user_id,
          "uid:uid_tn" => uid,
          "uid:uid" => uid,
          "uid:stufe" => "2"
        }
      end.to_hash[:uid_abfrage_response][:rc] == "0"
    end

    def login(client)
      self.session_id = client.request("urn", "Login") do |r|
        r.body = {
          "urn:tid"   => UidAt.subscriber_id,
          "urn:benid" => UidAt.user_id,
          "urn:pin"   => UidAt.pin
        }
      end.to_hash[:login_response][:result]
    end

    def logout(client)
      req = client.request("urn", "Logout") do |r|
        r.body = {
          "urn:id" => self.session_id,
          "urn:tid" => UidAt.subscriber_id,
          "urn:benid" => UidAt.user_id
        }
      end.to_hash[:logout_response][:result] == self.session_id
    end
    
  end
end
