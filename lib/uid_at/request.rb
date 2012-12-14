module UidAt
  class Request
    def initialize(uid, options)
      @uid = uid
      @options = options
    end

    def perform(client)
      client.request("urn", "Login") do |r|
        r.body = body
      end.to_hash #[response_key]
    end

    private

    def body
      {
        "urn:tid"   => @options.subscriber,
        "urn:benid" => @options.user,
        "urn:pin"   => @options.pin
      }
    end

    def response_key
      :check_vat_response
    end
  end
end
