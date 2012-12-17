module UidAt
  module Config
    def self.subscriber_id
      @@subscriber_id
    end

    def self.subscriber_id=(subscriber_id)
      @@subscriber_id = subscriber_id
    end

    def self.user_id
      @@user_id
    end

    def self.user_id=(user_id)
      @@user_id = user_id
    end

    def self.pin
      @@pin
    end

    def self.pin=(pin)
      @@pin = pin
    end

    def self.config(&block)
      yield(self)
    end
  end
end
