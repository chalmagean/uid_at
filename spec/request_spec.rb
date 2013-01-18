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

    it "delegates a login request to the API" do
      client.should_receive(:request).with("urn", "Login").and_return({:login_response => {:result => "ok"}})
      request.login(client)
    end

    it "returns and sets the session_id when logged in successfuly" do
      client.stub(:request).with("urn", "Login").and_return({:login_response => {:result => "ok"}})
      request.login(client).should == "ok"
    end
  end

  describe "#logout" do
    let(:client) { stub("client") }
    let(:request) { UidAt::Request.new }

    it "delegates a logout request to the API" do
      request.stub(:session_id)
      client.should_receive(:request).with("urn", "Logout").and_return({:logout_response => {:result => "ok"}})
      request.logout(client)
    end

    it "returns true if logged out successfuly" do
      request.stub(:session_id).and_return("ok")
      client.stub(:request).with("urn", "Logout").and_return({:logout_response => {:result => "ok"}})
      request.logout(client).should == true
    end
  end

  describe "#perform" do
    let(:client) { stub("client") }
    let(:request) { UidAt::Request.new }

    it "delegates the data validation to the API" do
      client.should_receive(:request).with("uid", "uidAbfrageRequest").and_return({:uid_abfrage_response => {:rc => "0"}})
      request.perform("someUID", client).should == true
    end

    it "returns a hash if details where requested" do
      client.stub(:request).with("uid", "uidAbfrageRequest").and_return({:uid_abfrage_response => {:rc=>"0", :adrz1=>"A-1110 Wien", :name=>"Foobar John"}})
      request.perform("someUID", client, :details => true).should include(:name => "Foobar John")
    end

    it "returns true if no details where requested" do
      client.stub(:request).with("uid", "uidAbfrageRequest").and_return({:uid_abfrage_response => {:rc=>"0", :adrz1=>"A-1110 Wien", :name=>"Foobar John"}})
      request.perform("someUID", client).should == true
    end
  end
end
