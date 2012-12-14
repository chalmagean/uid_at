module UidAt
  class Validator
    def initialize(uid)
    end

    def valid?
      UidAt::Lookup.validate(self)
    end
  end
end
