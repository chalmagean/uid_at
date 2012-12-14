require 'spec_helper'
require 'uid_at/validator'
require 'uid_at/lookup'

describe UidAt::Validator do
  describe "#new" do
    it "needs just one argument" do
      lambda { UidAt::Validator.new }.should raise_error(ArgumentError)
      lambda { UidAt::Validator.new("a", "b") }.should raise_error(ArgumentError)
      lambda { UidAt::Validator.new("a") }.should_not raise_error
    end
  end

  describe "#valid?" do
    let(:uid) { UidAt::Validator.new("abcde") }

    before :each do
      UidAt::Config.config do |config|
        config.subscriber = "johndoe"
        config.user = "johndoesmom"
        config.pin = "1234"
      end
    end

    it "return true if the uid is valid" do
      uid.should be_valid
    end

    it "returns false on invalid uids" do
      uid.should_not be_valid
    end
  end
end
