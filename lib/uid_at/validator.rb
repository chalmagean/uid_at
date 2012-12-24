module UidAt
  class Validator
    def initialize(uid)
      @uid = uid
    end

    def valid?
      UidAt::Lookup.validate(@uid)
    end
  end
end
