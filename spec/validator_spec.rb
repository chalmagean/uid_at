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
    let(:uid) { UidAt::Validator.new("bcde") }

    it "return true if the uid is valid" do
      UidAt::Lookup.stub(:get_uid_details).and_return(true)
      uid.valid?.should == true
    end

    it "returns false on invalid uids" do
      UidAt::Lookup.stub(:get_uid_details).and_return(false)
      uid.valid?.should == false
    end
  end
end
