require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class HubSpot < OmniAuth::Strategies::OAuth2
      option :name, "hubspot"

      args [:client_id, :client_secret]

      option :client_options, {
        site: 'https://api.hubapi.com',
        authorize_url: 'https://app.hubspot.com/oauth/authorize',
        token_url: 'oauth/v1/token'
      }
    
      def callback_url
        full_host + script_name + callback_path
      end

      def full_host #https://github.com/omniauth/omniauth/issues/101
        uri = URI.parse(request.url)
        uri.path = ''
        uri.query = nil
        uri.port = (uri.scheme == 'https' ? 443 : 80)
        uri.to_s
      end
    end
  end
end

OmniAuth.config.add_camelization 'hubspot', 'HubSpot'
