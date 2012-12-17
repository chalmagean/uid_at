require 'spec_helper'

describe UidAt::Request do
  describe "#new" do
    it "takes no arguments" do
      lambda { UidAt::Request.new }.should_not raise_error
      lambda { UidAt::Request.new("a") }.should raise_error(ArgumentError)
    end
  end

  describe "#login" do
    let(:client) { stub("client") }
    let(:request) { UidAt::Request.new }

    it "delegates a login request to the lookup client" do
      client.should_receive(:request).with("urn", "Login").and_return({:login_response => {:result => "ok"}})
      request.login(client)
    end

    it "returns the session id when logged in successfuly" do
      client.stub(:request).with("urn", "Login").and_return({:login_response => {:result => "ok"}})
      request.login(client).should == "ok"
    end
  end

  describe "#logout" do
    let(:client) { stub("client") }
    let(:request) { UidAt::Request.new }

    it "delegates a logout request to the lookup client" do
      request.stub(:session_id)
      client.should_receive(:request).with("urn", "Logout").and_return({:login_response => {:result => "ok"}})
      request.logout(client)
    end

    it "returns true if logged out successfuly" do
      request.stub(:session_id).and_return("ok")
      client.stub(:request).with("urn", "Logout").and_return({:login_response => {:result => "ok"}})
      request.logout(client).should == true
    end
  end
end
