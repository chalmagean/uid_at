require 'net/http'

module UidAt
  module Lookup
    def validate(uid)
      request = UidAt::Request.new(uid)

      response = request.perform(self.client)
      response
    end

    def client
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
