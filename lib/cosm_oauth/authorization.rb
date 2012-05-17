require 'addressable/uri'
require 'oj'

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

        uri = Addressable::URI.parse("#{OAUTH_BASE}/token")
        request = Net::HTTP::Post.new(uri.path)
        request.body = Addressable::URI.form_encode(:code => @code,
                                                    :client_id => @client_id,
                                                    :client_secret => @client_secret,
                                                    :grant_type => "authorization_code",
                                                    :redirect_uri => @redirect_uri)

        headers = { 'User-Agent' => @user_agent }
        request.initialize_http_header(headers)

        http = Net::HTTP.new(uri.host, uri.port)

        if uri.scheme == 'https'
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end

        response = http.request(request)

        raise "Error obtaining access_token: #{response.code} #{response.body}" unless response.code.to_i == 200

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
