require 'spec_helper'

describe Cosm::OAuth::Client do
  before(:each) do
    @client = Cosm::OAuth::Client.new(:client_id => "12345", :client_secret => "abcdefg12345", :redirect_uri => "http://localhost/callback")
    stub_request(:post, "https://cosm.com:80/oauth/token").
      with(:body => Addressable::URI.form_encode(:code => "code", :client_id => @client.client_id,
                                                 :client_secret => @client.client_secret,
                                                 :grant_type => "authorization_code",
                                                 :redirect_uri => @client.redirect_uri),
           :headers => {'User-Agent' => Cosm::OAuth::DEFAULT_USER_AGENT }).
      to_return(:status => 200, :body => '{"access_token":"access_token","user":"user"}')
  end

  it "should be creatable" do
    @client.should_not be_nil
  end

  it "should have instance variables set as expected" do
    @client.client_id.should == "12345"
    @client.client_secret.should == "abcdefg12345"
    @client.redirect_uri.should == "http://localhost/callback"
  end

  it "should generate an authorization_url" do
   @client.authorization_url.should == "https://cosm.com/oauth/authorize?client_id=12345&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%2Fcallback"
  end

  it "should be able to pass a state parameter into the authorization_url method" do
   @client.authorization_url("quentin fog").should == "https://cosm.com/oauth/authorize?client_id=12345&state=quentin+fog&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%2Fcallback"
  end

  it "should have a method for fetching an access_token" do
   @client.fetch_access_token("code")
   @client.access_token.should == "access_token"
   @client.user.should == "user"
  end

  it "should have an authorized? method" do
   @client.should_not be_authorized
   @client.fetch_access_token("code")
   @client.should be_authorized
  end

  it "should be possible to set the access_token and user" do
    @client.should_not be_authorized
    @client.access_token = "12345"
    @client.user = "bob"
    @client.should be_authorized
  end

end
