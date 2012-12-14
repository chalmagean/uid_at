module UidAt
  module Config
    def self.subscriber
      @@subscriber
    end

    def self.subscriber=(subscriber)
      @@subscriber = subscriber
    end

    def self.user
      @@user
    end

    def self.user=(user)
      @@user = user
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
