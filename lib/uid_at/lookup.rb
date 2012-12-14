require 'uid_at'
require 'uid_at/request'
require 'uid_at/config'
require 'net/http'

module UidAt
  module Lookup
    def self.validate(uid)
      request = UidAt::Request.new(uid, UidAt::Config)

      response = request.perform(self.client)
      response[:valid]
    end

    def self.client
      @client ||= begin
        # Require Savon only if really needed!
        require 'savon' unless defined?(Savon)

        # Quiet down Savon and HTTPI
        Savon.configure do |config|
          config.log = false
        end
        HTTPI.log = false

        Savon::Client.new do
          wsdl.document = 'https://finanzonline.bmf.gv.at/fon/services/SessionWSI/wsdl/SessionWSIService.wsdl'
        end
      end
    end
  end
end
