require 'openssl'
require 'addressable/uri'
require 'oj'
require 'rest_client'

module Cosm
  module OAuth
    module Authorization

      def authorization_url(state = nil)
        params = { :client_id => @client_id,
                   :state => state,
                   :response_type => "code",
                   :redirect_uri => @redirect_uri }.delete_if { |key, val| val.to_s == "" }
        return "#{OAUTH_BASE}/authenticate?#{Addressable::URI.form_encode(params)}"
      end

      def fetch_access_token(code)
        @code = code

        response = RestClient.post("#{OAUTH_BASE}/token",
                                   { :code => @code,
                                     :client_id => @client_id,
                                     :client_secret => @client_secret,
                                     :grant_type => "authorization_code",
                                     :redirect_uri => @redirect_uri },
                                    { 'Accept' => '*/*', 'User-Agent' => @user_agent })

        raise "Error obtaining access_token: #{response.code} #{response.body}" unless response.code == 200

        parsed = Oj.load(response.body)

        @access_token = parsed["access_token"]
        @user = parsed["user"]
      end

      def authorized?
        return !@access_token.nil? && !@user.nil?
      end
    end
  end
end
