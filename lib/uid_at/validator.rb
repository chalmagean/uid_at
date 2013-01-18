module UidAt
  class Validator
    def initialize(uid)
      @uid = uid
    end

    def valid?
      UidAt::Lookup.get_uid_details(@uid,:details=>false)
    end

    def get_details
      UidAt::Lookup.get_uid_details(@uid)    	
    end
  end
end
