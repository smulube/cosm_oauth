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

      def get(resource, params = {}, headers = {})
        raise "No OAuth credentials present " unless authorized?
        headers = prepare_headers(headers)
        response = RestClient.get(url(resource, params), headers)
        return response.body
      end

      def post(resource, data, headers = {})
        raise "No OAuth credentials present " unless authorized?
        headers = prepare_headers(headers)
        RestClient.post(url(resource), data, headers)
      end

      def put(endpoint, data, headers = {})
        raise "No OAuth credentials present " unless authorized?
        headers = prepare_headers(headers)
        RestClient.put(url(resource), data, headers)
      end

      def delete(endpoint, headers = {})
        raise "No OAuth credentials present " unless authorized?
        headers = prepare_headers(headers)
        RestClient.delete(url(resource), headers)
      end

      private

      def url(resource, params = {})
        url = API_BASE
        url += "/" unless resource.match(/^\//)
        url += resource
        unless params.empty?
          url += "?"
          url += Addressable::URI.form_encode(params)
        end
        return url
      end

      def prepare_headers(headers)
        headers ||= {}
        headers[:user_agent] ||= @user_agent
        headers[:authorization] = "Bearer #{@access_token}"
        return headers
      end
    end
  end
end
