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

    def perform(client)
      login
      logout
    end

    def login(client)
      client.request("urn", "Login") do |r|
        r.body = {
          "urn:tid"   => subscriber_id,
          "urn:benid" => user_id,
          "urn:pin"   => pin
        }
      end.to_hash[:login_response][:result]
    end

    def logout(client)
      client.request("urn", "Logout") do |r|
        r.body = {
          "urn:id" => session_id,
          "urn:tid" => subscriber_id,
          "urn:benid" => user_id
        }
      end.to_hash[:login_response][:result] == session_id
    end
    
  end
end
