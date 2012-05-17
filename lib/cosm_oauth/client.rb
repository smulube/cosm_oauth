require 'addressable/uri'
require "cosm_oauth/authorization"

module Cosm
  module OAuth

    DEFAULT_USER_AGENT = "Cosm Ruby Client (#{Cosm::OAuth::VERSION})"
    OAUTH_BASE = "https://cosm.com/oauth"
    API_BASE = "https://api.cosm.com/v2"

    class Client
      include Cosm::OAuth::Authorization

      attr_accessor :client_id, :client_secret, :redirect_uri, :scope, :user_agent, :code, :access_token, :user

      def initialize(options = {})
        @client_id = options[:client_id]
        @client_secret = options[:client_secret]
        @redirect_uri = options[:redirect_uri]
        @scope = options[:scope]
        @user_agent = options[:user_agent] || DEFAULT_USER_AGENT
      end

      def get(endpoint, params = nil, options = {})
      end

      def post(endpoint, data, options = {})
      end

      def put(endpoint, data, options = {})
      end

      def delete(endpoint, options = {})
      end

      private

      def request(method, endpoint, body, options = {})
      end
    end
  end
end
