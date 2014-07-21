class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  before_filter do
    @is_admin = session[:admin] == true
  end

protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def authenticate
    if Rails.env.development?
      login = authenticate_or_request_with_http_basic do |username, password|
        username == ENV['USERNAME'] && Digest::SHA1.hexdigest(password) == ENV['PASSWORD_HASH']
      end
    end
  end

  def admin_login
    if login = authenticate_or_request_with_http_basic { |u, p| u == ENV['ADMIN_USERNAME'] && Digest::SHA1.hexdigest(p) == ENV['ADMIN_PASSWORD_HASH'] }
      session[:admin] = true
    end
  end
end
