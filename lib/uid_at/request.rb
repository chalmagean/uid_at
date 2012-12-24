module UidAt
  class Request
    ATTRIBUTES = [:subscriber_id, :user_id, :pin].freeze

    ATTRIBUTES.each do |attr|
      attr_accessor attr
    end

    attr_accessor :session_id

    def initialize
      ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr}", UidAt::Config.send(attr))
      end
    end

    def perform(uid, client)
      client.request("uid", "uidAbfrageRequest") do |r|
        r.body = {
          "uid:sessionid" => session_id,
          "uid:tid"   => subscriber_id,
          "uid:benid" => user_id,
          "uid:uid_tn" => uid,
          "uid:uid" => uid,
          "uid:stufe" => "2"
        }
      end.to_hash[:uid_abfrage_response][:rc] == "0"
    end

    def login(client)
      self.session_id = client.request("urn", "Login") do |r|
        r.body = {
          "urn:tid"   => self.subscriber_id,
          "urn:benid" => self.user_id,
          "urn:pin"   => self.pin
        }
      end.to_hash[:login_response][:result]
    end

    def logout(client)
      req = client.request("urn", "Logout") do |r|
        r.body = {
          "urn:id" => self.session_id,
          "urn:tid" => self.subscriber_id,
          "urn:benid" => self.user_id
        }
      end.to_hash[:logout_response][:result] == self.session_id
    end
    
  end
end
