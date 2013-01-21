require 'net/http'

module UidAt
  module Lookup
    def self.get_uid_details(uid,options={:details=>true})
      request = UidAt::Request.new

      # Gotta authenticate
      request.login(self.auth_client)

      # Check if the uid is valid or not
      response = request.perform(uid, self.uid_client,options)

      # Clening up after ourselves
      request.logout(self.auth_client)

      response      
    end

    private

    def self.uid_client
      self.client_config
      Savon::Client.new do
        wsdl.endpoint = "https://finanzonline.bmf.gv.at/fon/ws/uidAbfrageService"
        wsdl.namespace = "https://finanzonline.bmf.gv.at/fon/ws/uid"
      end
    end

    def self.auth_client
      self.client_config
      Savon::Client.new("https://finanzonline.bmf.gv.at/fon/services/SessionWSI/wsdl/SessionWSIService.wsdl")
    end

    def self.client_config
      # Require Savon only if really needed!
      require 'savon' unless defined?(Savon)

      # Quiet down Savon and HTTPI
      Savon.configure do |config|
        config.log = false
      end
      HTTPI.log = false
    end

  end
end
