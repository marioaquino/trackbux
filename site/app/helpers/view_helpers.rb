module ViewHelpers
  def authentication_url
    @app_url ||= "https://#{app_name}.rpxnow.com/openid/start?token_url=http://#{site_url}/login"
  end
end