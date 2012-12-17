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

    it "return true if the uid is valid" do
      uid.should == true
    end

    it "returns false on invalid uids" do
      uid.should_not be_valid
    end
  end
end
