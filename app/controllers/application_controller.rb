class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def authenticate
    if Rails.env.development?
      binding.pry
      login = authenticate_or_request_with_http_basic do |username, password|
        username == "kollektiv" && Digest::SHA1.hexdigest(password) == "bfcb9ec698b0ef2330efee368e89886505b27b0d"
      end
    end
  end
end
